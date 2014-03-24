//
//  AEDataViewController.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEDataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (nonatomic, strong) NSMutableArray *answers;

@property (nonatomic) int selectCounter;

@end
