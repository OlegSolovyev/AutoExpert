//
//  AEDataViewController.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    symptomCategorySelect,
    symptomSelect,
} state;

@interface AEDataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *answers;

@property (nonatomic) int selectCounter;
@property (nonatomic) state currentState;

@end
