//
//  AESymptom.h
//  AutoExpert
//
//  Created by Solo on 5/25/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AESymptomSpecification.h"

typedef enum{
    engine,
    coolingSystem,
    fuelSystem,
    clutch,
    transmission,
    suspension,
    steering
} SymptomCategoryIndex;

#define NUMBER_OF_SYMPTOM_CATEGORIES 7

@interface AESymptom : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic) SymptomCategoryIndex categoryIndex;
@property (nonatomic, retain) NSMutableArray *causes;

@property (nonatomic) BOOL injector;
@property (nonatomic) BOOL carburetor;
@property (nonatomic) BOOL gasEngine;
@property (nonatomic) BOOL dieselEngine;
@property (nonatomic) BOOL automaticTransmission;
@property (nonatomic) BOOL manualTransmission;



@end
