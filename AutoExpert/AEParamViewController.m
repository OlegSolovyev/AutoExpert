//
//  AEParamViewController.m
//  AutoExpert
//
//  Created by Solo on 3/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AEParamViewController.h"
#import "AEUserDataManager.h"
#import "AECarsDataBaseManager.h"

#define KPP_TEXT @"РКПП"
#define AKPP_TEXT @"АКПП"
#define GAS_ENGINE_TEXT @"Бензиновый двигатель"
#define DIESEL_ENGINE_TEXT @"Дизельный двигатель"
#define INJECTOR_TEXT @"Инжектор"
#define CARBURETOR_TEXT @"Карбюратор"

@implementation AEParamViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.kppLabel.text = KPP_TEXT;
    self.engineLabel.text = GAS_ENGINE_TEXT;
    self.injectorLabel.text = INJECTOR_TEXT;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.scrollView addGestureRecognizer:self.tapRecognizer];
    NSLog(@"Current car: %@", [[AEUserDataManager sharedManager] currentCar].model.name);
    if([[AEUserDataManager sharedManager] currentCar].model.automaticTransmission
       && [[AEUserDataManager sharedManager] currentCar].model.manualTransmission){
        [self.kppSwitch setEnabled:YES];
    } else {
        [self.kppSwitch setEnabled:NO];
        if([[AEUserDataManager sharedManager] currentCar].model.automaticTransmission){
            [self.kppLabel setText:AKPP_TEXT];
            [self.kppSwitch setOn:NO];
        } else{
            [self.kppLabel setText:KPP_TEXT];
            [self.kppSwitch setOn:YES];
        }
    }
    if([[AEUserDataManager sharedManager] currentCar].model.dieselEngine
       && [[AEUserDataManager sharedManager] currentCar].model.gasEngine){
        [self.engineSwitch setEnabled:YES];
    } else {
        [self.engineSwitch setEnabled:NO];
        if([[AEUserDataManager sharedManager] currentCar].model.dieselEngine){
            [self.engineLabel setText:DIESEL_ENGINE_TEXT];
            [self.engineSwitch setOn:NO];
        } else{
            [self.engineLabel setText:GAS_ENGINE_TEXT];
            [self.engineSwitch setOn:YES];
        }
    }
    if([[AEUserDataManager sharedManager] currentCar].model.injector
       && [[AEUserDataManager sharedManager] currentCar].model.carburetor){
        [self.injectorSwitch setEnabled:YES];
    } else {
        [self.injectorSwitch setEnabled:NO];
        if([[AEUserDataManager sharedManager] currentCar].model.injector){
            [self.injectorLabel setText:INJECTOR_TEXT];
            [self.injectorSwitch setOn:YES];
        } else{
            [self.injectorLabel setText:CARBURETOR_TEXT];
            [self.injectorSwitch setOn:NO];
        }
    }
}

- (void)hideKeyboard{
    [self.view endEditing:YES];
}

- (IBAction)engineValueChanged:(id)sender {
    if([self.engineLabel.text isEqualToString:GAS_ENGINE_TEXT]){
        self.engineLabel.text = DIESEL_ENGINE_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setEngine:diesel];
    } else{
        self.engineLabel.text = GAS_ENGINE_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setEngine:gasoline];
    }
}

- (IBAction)injectorValueChanged:(id)sender {
    if([self.injectorLabel.text isEqualToString:INJECTOR_TEXT]){
        self.injectorLabel.text = CARBURETOR_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setInjectionType:carburetor];
    } else{
        self.injectorLabel.text = INJECTOR_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setInjectionType:injector];
    }
}

- (IBAction)kppValueChanged:(id)sender {
    if([self.kppLabel.text isEqualToString:KPP_TEXT]){
        self.kppLabel.text = AKPP_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setTransmission:automaticDSG];
    } else{
        self.kppLabel.text = KPP_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setTransmission:manual];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[[AEUserDataManager sharedManager] currentCar] setDistance:[self.wayTextField.text intValue]];
}

@end
