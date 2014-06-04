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
    if([[AEUserDataManager sharedManager] currentCar].model.DSG
       && [[AEUserDataManager sharedManager] currentCar].model.manualTransmission){
        [self.kppSwitch setEnabled:YES];
        [self.kppLabel setText:KPP_TEXT];
        [self.kppSwitch setOn:YES];
        [[[AEUserDataManager sharedManager] currentCar] setTransmission:manual];
    } else {
        [self.kppSwitch setEnabled:NO];
        if([[AEUserDataManager sharedManager] currentCar].model.DSG){
            [self.kppLabel setText:AKPP_TEXT];
            [self.kppSwitch setOn:NO];
            [[[AEUserDataManager sharedManager] currentCar] setTransmission:DSG];
        } else{
            [self.kppLabel setText:KPP_TEXT];
            [self.kppSwitch setOn:YES];
            [[[AEUserDataManager sharedManager] currentCar] setTransmission:manual];
        }
    }
    if([[AEUserDataManager sharedManager] currentCar].model.dieselEngine
       && [[AEUserDataManager sharedManager] currentCar].model.gasEngine){
        [self.engineSwitch setEnabled:YES];
        [self.engineLabel setText:GAS_ENGINE_TEXT];
        [self.engineSwitch setOn:YES];
        [[[AEUserDataManager sharedManager] currentCar] setEngine:gasoline];
    } else {
        [self.engineSwitch setEnabled:NO];
        if([[AEUserDataManager sharedManager] currentCar].model.dieselEngine){
            [self.engineLabel setText:DIESEL_ENGINE_TEXT];
            [self.engineSwitch setOn:NO];
            [[[AEUserDataManager sharedManager] currentCar] setEngine:diesel];
        } else{
            [self.engineLabel setText:GAS_ENGINE_TEXT];
            [self.engineSwitch setOn:YES];
            [[[AEUserDataManager sharedManager] currentCar] setEngine:gasoline];
        }
    }
    if([[AEUserDataManager sharedManager] currentCar].model.injector
       && [[AEUserDataManager sharedManager] currentCar].model.carburetor){
        [self.injectorSwitch setEnabled:YES];
        [self.injectorLabel setText:INJECTOR_TEXT];
        [self.injectorSwitch setOn:YES];
        [[[AEUserDataManager sharedManager] currentCar] setInjectionType:injector];
    } else {
        [self.injectorSwitch setEnabled:NO];
        if([[AEUserDataManager sharedManager] currentCar].model.injector){
            [self.injectorLabel setText:INJECTOR_TEXT];
            [self.injectorSwitch setOn:YES];
            [[[AEUserDataManager sharedManager] currentCar] setInjectionType:injector];
        } else{
            [self.injectorLabel setText:CARBURETOR_TEXT];
            [self.injectorSwitch setOn:NO];
            [[[AEUserDataManager sharedManager] currentCar] setInjectionType:carburetor];
        }
    }
}

- (void)hideKeyboard{
    [self.view endEditing:YES];
}

- (IBAction)engineValueChanged:(id)sender {
    if(![sender isOn]){
        self.engineLabel.text = DIESEL_ENGINE_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setEngine:diesel];
    } else{
        self.engineLabel.text = GAS_ENGINE_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setEngine:gasoline];
    }
}

- (IBAction)injectorValueChanged:(id)sender {
    if(![sender isOn]){
        self.injectorLabel.text = CARBURETOR_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setInjectionType:carburetor];
    } else{
        self.injectorLabel.text = INJECTOR_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setInjectionType:injector];
    }
}

- (IBAction)kppValueChanged:(id)sender {
    if(![sender isOn]){
        self.kppLabel.text = AKPP_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setTransmission:DSG];
    } else{
        self.kppLabel.text = KPP_TEXT;
        [[[AEUserDataManager sharedManager] currentCar] setTransmission:manual];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[[AEUserDataManager sharedManager] currentCar] setDistance:[self.wayTextField.text intValue]];
}

@end
