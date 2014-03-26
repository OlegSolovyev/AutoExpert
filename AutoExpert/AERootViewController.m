//
//  AERootViewController.m
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AERootViewController.h"
#import "AEDataViewController.h"
#import "AECarsDataBaseManager.h"
#import "AEUserDataManager.h"

@implementation AERootViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.modelsArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < NUMBER_OF_MODELS; ++i){
        [self.modelsArray addObject:[AECarsDataBaseManager stringForModel:i]];
    }
    self.yearsArray = [[NSMutableArray alloc] init];
    for (int i = [AECarsDataBaseManager maxYearForModel:0]; i >= [AECarsDataBaseManager minYearForModel:0]; --i){
        [self.yearsArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    [self.scrollView setScrollEnabled:TRUE];
    [self.scrollView setContentSize:CGSizeMake(320, 1000)];
    
}

- (void)viewDidUnload{
    [super viewDidUnload];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;  // returns the number of 'columns' to display.
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([pickerView isEqual:self.yearPickerView]){
        return [self.yearsArray count];
    } else{
        return [self.modelsArray count];  // returns the number of rows in each component..
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([pickerView isEqual:self.yearPickerView]){
        return [self.yearsArray objectAtIndex:row];
    } else{
        return [self.modelsArray objectAtIndex:row];
    }
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView isEqual:self.yearPickerView]){
        self.selectedYear = [[self.yearsArray objectAtIndex:row] intValue];
        [[[AEUserDataManager sharedManager] currentCar] setYear:self.selectedYear];
    } else{
        self.selectedCar = [self.modelsArray objectAtIndex:row];
        [[[AEUserDataManager sharedManager] currentCar] setStringModel:self.selectedCar];
        [[[AEUserDataManager sharedManager] currentCar] setModel:[AECarsDataBaseManager modelForString: self.selectedCar]];
        [self.yearsArray removeAllObjects];
        for (int i = [AECarsDataBaseManager maxYearForModel:[AECarsDataBaseManager modelForString:self.selectedCar]]; i >= [AECarsDataBaseManager minYearForModel:[AECarsDataBaseManager modelForString:self.selectedCar]]; --i){
            [self.yearsArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        [self.yearPickerView reloadAllComponents];
    }
}


@end
