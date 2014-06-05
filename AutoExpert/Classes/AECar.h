//
//  AECar.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AECarModel.h"


@interface AECar : NSObject

@property (nonatomic) AECarModel *model;
@property (nonatomic) EngineType engine;
@property (nonatomic) InjectionType injectionType;
@property (nonatomic) TranmissionType transmission;
@property (nonatomic) int year;
@property (nonatomic) int distance;
@property (nonatomic) int distanceSinceService;

- (id)initWithParameters:(AECarModel *)model
                  engine:(EngineType)engine
            transmission:(TranmissionType)transmission
                    year:(int)year
                distance:(int)distance ;

@end
