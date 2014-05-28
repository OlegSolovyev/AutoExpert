//
//  AECarModel.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 27/03/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    gasoline,
    diesel
} EngineType;

typedef enum{
    manual,
    automatic,
    variator
} TranmissionType;

typedef enum{
    vaz2101,
    vaz2102,
    vaz2103,
    vaz2104,
    vaz2105,
    vaz2106,
    vaz2107,
    vaz2108,
    vaz2109,
    vaz2110,
} CarModelIndex;

#define NUMBER_OF_MODELS 10

typedef enum{
    carburetor,
    injector
} InjectionType;

@interface AECarModel : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic) CarModelIndex index;

@property (nonatomic) int minYear;
@property (nonatomic) int maxYear;

@property (nonatomic) BOOL injector;
@property (nonatomic) BOOL carburetor;
@property (nonatomic) BOOL gasEngine;
@property (nonatomic) BOOL dieselEngine;
@property (nonatomic) BOOL automaticTransmission;
@property (nonatomic) BOOL variatorTransmission;
@property (nonatomic) BOOL manualTransmission;

- (id)initWithModelIndex:(CarModelIndex)modelIndex;

@end
