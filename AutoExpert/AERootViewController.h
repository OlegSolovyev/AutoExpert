//
//  AERootViewController.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AERootViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *modelPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *brandPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *yearPickerView;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) NSMutableArray *brandsArray;
@property (nonatomic, retain) NSMutableArray *modelsArray;
@property (nonatomic, retain) NSMutableArray *yearsArray;

@end
