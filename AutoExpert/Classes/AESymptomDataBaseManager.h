//
//  AESymptomDataBaseManager.h
//  AutoExpert
//
//  Created by Solo on 5/25/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AESymptom.h"

@interface AESymptomDataBaseManager : NSObject

@property (nonatomic, retain) NSMutableArray *symptoms;

+ (id)sharedManager;
- (void)loadSymptoms;
+ (NSString *)nameForSymptomCategoryIndex:(SymptomCategoryIndex)symptomCategoryIndex;
+ (SymptomCategoryIndex)symptomCategoryIndexForName:(NSString *)name;
+ (NSMutableArray *)symptomCategoriesArray;
- (NSMutableArray *)symptomsForCategoryIndex:(SymptomCategoryIndex)index;
- (AESymptom *)symptomForName:(NSString *)name;
- (AESymptom *)symptomForIndex:(int)index;
@end
