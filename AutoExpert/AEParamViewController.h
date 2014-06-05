//
//  AEParamViewController.h
//  AutoExpert
//
//  Created by Solo on 3/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEParamViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet UILabel *kppLabel;
@property (weak, nonatomic) IBOutlet UILabel *injectorLabel;
@property (weak, nonatomic) IBOutlet UILabel *engineLabel;
@property (weak, nonatomic) IBOutlet UILabel *wayLabel;
@property (weak, nonatomic) IBOutlet UITextField *wayTextField;
@property (weak, nonatomic) IBOutlet UITextField *waySinceTOfield;
@property (weak, nonatomic) IBOutlet UISwitch *kppSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *injectorSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *engineSwitch;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)engineValueChanged:(id)sender;
- (IBAction)injectorValueChanged:(id)sender;
- (IBAction)kppValueChanged:(id)sender;

@end
