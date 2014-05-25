//
//  AEUserDataManager.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AECar.h"
#import "AESymptom.h"

@interface AEUserDataManager : NSObject

+ (id)sharedManager;
- (void)loadData;
+ (void)saveData;

@property (nonatomic, retain) AECar *currentCar;
@property (nonatomic) SymptomCategoryIndex selectedSymptomCategoryIndex;
@property (nonatomic, retain) AESymptom *selectedSymptom;

@end

