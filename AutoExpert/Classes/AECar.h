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
    LadaSamara,
    LadaClassic
} CarModel;

typedef enum{
    carburetor,
    injector
} InjectionType;



@interface AECar : NSObject

@property (nonatomic) NSString *model;
@property (nonatomic) EngineType engine;
@property (nonatomic) InjectionType injectionType;
@property (nonatomic) TranmissionType transmission;
@property (nonatomic) int year;
@property (nonatomic) int distance;

@end
