//
//  AESymptomDataBaseManager.m
//  AutoExpert
//
//  Created by Solo on 5/25/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AESymptomDataBaseManager.h"

static AESymptomDataBaseManager *sharedDataManager = nil;

@implementation AESymptomDataBaseManager
+ (id)sharedManager {
    if(sharedDataManager == nil)
        sharedDataManager = [[AESymptomDataBaseManager alloc] init];
    return sharedDataManager;
}

- (id)init{
    if( self = [super init]){

    }
    return self;
}

- (void)loadSymptoms{

    NSLog(@"Symptoms loaded");
}

+ (SymptomCategoryIndex)symptomCategoryIndexForName:(NSString *)name{
    SymptomCategoryIndex result = 0;
    for(int i = 0; i < NUMBER_OF_SYMPTOM_CATEGORIES; ++i){
        if([name isEqualToString:[AESymptomDataBaseManager nameForSymptomCategoryIndex:i]]){
            result = i;
        }
    }
    return result;
}

+ (NSString *)nameForSymptomCategoryIndex:(SymptomCategoryIndex)symptomCategoryIndex{
    NSString *result;
    switch (symptomCategoryIndex) {
        case engine:
            result = @"Двигатель";
            break;
        case coolingSystem:
            result = @"Система охлаждения";
            break;
        case fuelSystem:
            result = @"Топливная система";
            break;
        case clutch:
            result = @"Сцепление";
            break;
        case transmission:
            result = @"Коробка передач";
            break;
        case suspension:
            result = @"Подвеска";
            break;
        case steering:
            result = @"Рулевое управление";
            break;
            
        default:
            break;
    }
    return result;
}

+ (NSMutableArray *)symptomCategoriesArray{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(int i = 0; i < NUMBER_OF_SYMPTOM_CATEGORIES; ++i){
        [result addObject:[AESymptomDataBaseManager nameForSymptomCategoryIndex:i]];
    }
    return result;
}

- (NSMutableArray *)symptomsForCategoryIndex:(SymptomCategoryIndex)index{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(AESymptom *symptom in self.symptoms){
        if(symptom.categoryIndex == index){
            [result addObject:symptom];
        }
    }
    return result;
}

- (AESymptom *)symptomForName:(NSString *)name{
    for (AESymptom *symptom in self.symptoms){
        if([symptom.name isEqualToString:name]){
            return symptom;
        }
    }
    NSLog(@"-symptomForName ERROR: symptom '%@' not found", name);
    return nil;
}

@end
