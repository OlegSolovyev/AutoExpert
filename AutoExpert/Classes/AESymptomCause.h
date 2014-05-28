//
//  AESymptomCause.h
//  AutoExpert
//
//  Created by Solo on 5/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    common,
    engine,
    coolingSystem,
    fuelSystem,
    clutch,
    transmission,
    suspension,
    steering,
    breaking,
    carburetorCategory,
    starter,
    exhaustRecirculation,
    ignition

} SymptomCategoryIndex;

#define NUMBER_OF_SYMPTOM_CATEGORIES 13

@interface AESymptomCause : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *tags;
@property (nonatomic) int probability;
@property (nonatomic) int link;

@property (nonatomic) BOOL injector;
@property (nonatomic) BOOL carburetor;
@property (nonatomic) BOOL gasEngine;
@property (nonatomic) BOOL dieselEngine;
@property (nonatomic) BOOL automaticTransmission;
@property (nonatomic) BOOL variatorTransmission;
@property (nonatomic) BOOL manualTransmission;

- (id)initWithName:(NSString *)name
              tags:(NSArray *)tags
       probability:(int)probability
     link:(int)link;

- (NSComparisonResult)compareProbability:(AESymptomCause *)otherObject;
- (NSComparisonResult)compareLink:(AESymptomCause *)otherObject;
@end
