//
//  AEQuestionsViewController.m
//  AutoExpert
//
//  Created by Solo on 5/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AEQuestionsViewController.h"
#import "AEUserDataManager.h"

@interface AEQuestionsViewController ()

@end

@implementation AEQuestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.causes = [[NSMutableArray alloc] init];
    for(AESymptomCause *cause in [[AEUserDataManager sharedManager] selectedSymptom].causes){
        if([self causeIsAcceptableForCurrentCar:cause]){
            [self.causes addObject:cause];
        }
    }
    self.currentCause = 0;
    [self.textView setText:[[self.causes objectAtIndex:0] name]];
    self.textView.font = [UIFont systemFontOfSize:29];
    

	// Do any additional setup after loading the view.
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
    if(cause.automaticTransmission && car.transmission != automaticDSG) result = NO;
    if(cause.manualTransmission && car.transmission != manual) result = NO;
    
    return result;
}

- (IBAction)yesButtonPresses:(id)sender {
    [self.textView setText:[NSString stringWithFormat:@"Вы нашли причину неисправности : %@", [[self.causes objectAtIndex:self.currentCause] name]]];
    [self setHiddenForButtons:YES];
}

- (IBAction)noButtonPressed:(id)sender {
    if(self.currentCause != self.causes.count - 1){
        self.currentCause++;
        [self.textView setText:[[self.causes objectAtIndex:self.currentCause] name]];
        self.textView.font = [UIFont systemFontOfSize:29];
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
