//
//  AEParamViewController.m
//  AutoExpert
//
//  Created by Solo on 3/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AEParamViewController.h"
#import "AEUserDataManager.h"

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
