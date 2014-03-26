//
//  AECar.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    gasoline,
    diesel
} EngineType;

typedef enum{
    manual,
    automaticHydro,
    automaticDSG,
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
} CarModel;

#define NUMBER_OF_MODELS 10

typedef enum{
    carburetor,
    injector
} InjectionType;



@interface AECar : NSObject

@property (nonatomic) NSString *stringModel;
@property (nonatomic) CarModel model;
@property (nonatomic) EngineType engine;
@property (nonatomic) InjectionType injectionType;
@property (nonatomic) TranmissionType transmission;
@property (nonatomic) int year;
@property (nonatomic) int distance;

- (id)initWithParameters:(NSString *)stringModel
                   model:(CarModel)model
                  engine:(EngineType)engine
            transmission:(TranmissionType)transmission
                    year:(int)year
                distance:(int)distance ;

@end
