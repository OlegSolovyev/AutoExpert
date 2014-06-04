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
#import "AESymptomDataBaseManager.h"

@implementation AERootViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[AECarsDataBaseManager sharedManager] loadModels];
    [[AESymptomDataBaseManager sharedManager] loadSymptoms];
    
    self.brandsArray = [[NSMutableArray alloc] init];
    self.modelsArray = [[NSMutableArray alloc] init];
    self.yearsArray = [[NSMutableArray alloc] init];
    
    for(AECarModel *model in [[AECarsDataBaseManager sharedManager] models]){
        if(![self.brandsArray containsObject:model.brand])[self.brandsArray addObject:model.brand];
    }
    
    for(AECarModel *model in [[AECarsDataBaseManager sharedManager] models]){
        if([model.brand isEqualToString:[[[[AECarsDataBaseManager sharedManager] models] objectAtIndex:0] brand]]){
            [self.modelsArray addObject:model.name];
        }
    }
    
    for (int i = [[[[AECarsDataBaseManager sharedManager] models] objectAtIndex:0] maxYear]; i >= [[[[AECarsDataBaseManager sharedManager] models] objectAtIndex:0] minYear]; --i){
        [self.yearsArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
//    [self.scrollView setScrollEnabled:TRUE];
//    [self.scrollView setContentSize:CGSizeMake(320, 1000)];
    

    
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
    } else if([pickerView isEqual:self.brandPickerView]){
        return [self.brandsArray count];
    } else{
        return [self.modelsArray count];
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
    } else if([pickerView isEqual:self.brandPickerView]){
        return [self.brandsArray objectAtIndex:row];
    } else{
        return [self.modelsArray objectAtIndex:row];
    }
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView isEqual:self.yearPickerView]){
        [[[AEUserDataManager sharedManager] currentCar] setYear:[[self.yearsArray objectAtIndex:row] intValue]];
    } else if([pickerView isEqual:self.brandPickerView]){
        [self.modelsArray removeAllObjects];
        for(AECarModel *model in [[AECarsDataBaseManager sharedManager] models]){
            if([model.brand isEqualToString:[self.brandsArray objectAtIndex:row]]){
                [self.modelsArray addObject:model.name];
            }
            
            [self.modelPickerView reloadAllComponents];
        }
    } else{
        for(AECarModel *model in [[AECarsDataBaseManager sharedManager] models]){
            if([model.brand isEqualToString:[self.brandsArray objectAtIndex:[self.brandPickerView selectedRowInComponent:0]]]
               && [model.name isEqualToString:[self.modelsArray objectAtIndex:[self.modelPickerView selectedRowInComponent:0]]]){
                [[[AEUserDataManager sharedManager] currentCar] setModel:model];
                break;
            }
        }
        [self.yearsArray removeAllObjects];
        for (int i = [[[AEUserDataManager sharedManager] currentCar] model].maxYear; i >= [[[AEUserDataManager sharedManager] currentCar] model].minYear; --i){
            [self.yearsArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        [self.yearPickerView reloadAllComponents];
    }
}


@end
