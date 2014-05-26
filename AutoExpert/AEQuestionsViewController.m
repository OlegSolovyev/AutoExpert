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
    self.causes = [NSMutableArray arrayWithArray:[[AEUserDataManager sharedManager] selectedSymptom].causes];
    self.currentCause = 0;
    [self.textView setText:[self.causes objectAtIndex:0]];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)yesButtonPresses:(id)sender {
    if(self.currentCause != self.causes.count - 1){
        self.currentCause++;
        [self.textView setText:[self.causes objectAtIndex:self.currentCause]];
    } else{
        [self.textView setText:@"Обратитесь к механику. Система не знает как Вам помочь"];
        [self setHiddenForButtons:YES];
    }
}

- (IBAction)noButtonPressed:(id)sender {
    [self.textView setText:[NSString stringWithFormat:@"Вы нашли причину неисправности : %@", [self.causes objectAtIndex:self.currentCause]]];
    [self setHiddenForButtons:YES];
}

- (void)setHiddenForButtons:(BOOL)hidden{
    [self.yesButton setHidden:hidden];
    [self.noButton setHidden:hidden];
}

@end
