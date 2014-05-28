//
//  AEQuestionsViewController.m
//  AutoExpert
//
//  Created by Solo on 5/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AEQuestionsViewController.h"
#import "AEUserDataManager.h"
#import "AESymptomDataBaseManager.h"

typedef enum{
    normalState,
    forkState,
    backingState
} state;

@interface AEQuestionsViewController ()

@property (nonatomic) state state;
@property (nonatomic, retain) NSMutableArray *causes;
@property (nonatomic) int currentCause;
@property (nonatomic, retain) NSMutableArray *symptomsOpened;
@property (nonatomic, retain) NSMutableArray *lastCauses;

@end

@implementation AEQuestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Назад" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.symptomsOpened = [[NSMutableArray alloc]init];
    self.lastCauses = [[NSMutableArray alloc] init];
    self.causes = [[NSMutableArray alloc] init];
    [self setSymptomInfo];
    [self setCauseInfo];
    

	// Do any additional setup after loading the view.
}

- (void)backButtonAction:(id)sender{
    if (self.state == normalState) {
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"Backing at normal state");
    } else if(self.state == forkState){
        if(self.symptomsOpened.count > 0){
            [[AEUserDataManager sharedManager] setSelectedSymptom:[self.symptomsOpened objectAtIndex:self.symptomsOpened.count - 1]];
            self.state = backingState;
            [self setSymptomInfo];
            [self setCauseInfo];
            [self.symptomsOpened removeObjectAtIndex:self.symptomsOpened.count - 1];
            [self.lastCauses removeObjectAtIndex:self.lastCauses.count - 1];
        } else{
            self.state = normalState;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else{
        NSLog(@"ERROR : Wrong state");
    }
}

- (void)setSymptomInfo{
    [self.causes removeAllObjects];
    for(AESymptomCause *cause in [[AEUserDataManager sharedManager] selectedSymptom].causes){
        if([self causeIsAcceptableForCurrentCar:cause]){
            [self.causes addObject:cause];
        }
    }
    if(self.state == backingState){
        [self.causes removeObjectsInRange:NSMakeRange(0, [[self.lastCauses objectAtIndex:self.lastCauses.count - 1] intValue])];
        if(self.symptomsOpened.count > 1){
            self.state = forkState;
        } else{
            self.state = normalState;
        }
    }
    self.currentCause = 0;
    [self.symptomLabel setText:[[[AEUserDataManager sharedManager] selectedSymptom] name]];

}

- (void)setCauseInfo{
    [self.textView setText:[[self.causes objectAtIndex:self.currentCause] name]];
    self.textView.font = [UIFont systemFontOfSize:29];
    if([[self.causes objectAtIndex:self.currentCause] link] != 0){
        [self.yesButton setTitle:@"Проверить" forState:UIControlStateNormal];
        [self.noButton setTitle:@"Пропустить" forState:UIControlStateNormal];
        self.state = forkState;
    } else{
        [self.yesButton setTitle:@"Да" forState:UIControlStateNormal];
        [self.noButton setTitle:@"Нет" forState:UIControlStateNormal];
        self.state = normalState;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)causeIsAcceptableForCurrentCar:(AESymptomCause *)cause{
    BOOL result = YES;
    AECar *car = [[AEUserDataManager sharedManager] currentCar];
    
    if(cause.injector && car.injectionType != injector) result = NO;
    if(cause.carburetor && car.injectionType != carburetor) result = NO;
    if(cause.gasEngine && car.engine != gasoline) result = NO;
    if(cause.dieselEngine && car.engine != diesel) result = NO;
    if(cause.automaticTransmission && car.transmission != automatic) result = NO;
    if(cause.manualTransmission && car.transmission != manual) result = NO;
    
    return result;
}

- (IBAction)yesButtonPressed:(id)sender {
    if(self.state == normalState){
        [self.textView setText:[NSString stringWithFormat:@"Вы нашли причину неисправности : %@", [[self.causes objectAtIndex:self.currentCause] name]]];
        [self setHiddenForButtons:YES];
    } else{
        [self.symptomsOpened addObject:[[AEUserDataManager sharedManager] selectedSymptom]];
        [self.lastCauses addObject:[NSString stringWithFormat:@"%d",self.currentCause]];
        [[AEUserDataManager sharedManager] setSelectedSymptom:[[AESymptomDataBaseManager sharedManager] symptomForIndex:[[self.causes objectAtIndex:self.currentCause] link]]];
        [self setSymptomInfo];
        [self setCauseInfo];
        self.state = forkState;
    }
}

- (IBAction)noButtonPressed:(id)sender {
    if(self.currentCause != self.causes.count - 1){
        self.currentCause++;
        [self setCauseInfo];
    } else{
        [self.textView setText:@"Обратитесь к механику. Система не знает как Вам помочь"];
        self.textView.font = [UIFont systemFontOfSize:29];
        [self setHiddenForButtons:YES];
    }
}

- (void)setHiddenForButtons:(BOOL)hidden{
    [self.yesButton setHidden:hidden];
    [self.noButton setHidden:hidden];
}

@end
