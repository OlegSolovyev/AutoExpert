//
//  AECar.m
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AECar.h"

@implementation AECar

- (id)initWithParameters:(CarModel)model
                 engine:(EngineType)engine
           transmission:(TranmissionType)transmission
                   year:(int)year
               distance:(int)distance{
    if(self = [super init]){
        self.model = model;
        self.engine = engine;
        self.transmission = transmission;
        self.year = year;
        self.distance = distance;
    }
    
    return  self;
}

@end
