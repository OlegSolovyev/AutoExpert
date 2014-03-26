//
//  AECarsDataBaseManager.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 17/03/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AECar.h"

@interface AECarsDataBaseManager : NSObject

+ (id)sharedManager;
+ (NSString *)stringForModel:(CarModel)model;
+ (CarModel)modelForString:(NSString *)string;
+ (int)minYearForModel:(CarModel)model;
+ (int)maxYearForModel:(CarModel)model;
+ (BOOL)modelHasInjector:(CarModel)model;
+ (BOOL)modelHasCarburetor:(CarModel)model;
+ (BOOL)modelHasGasEngine:(CarModel)model;
+ (BOOL)modelHasDieselEngine:(CarModel)model;
+ (BOOL)modelHasAutomaticTransmission:(CarModel)model;
+ (BOOL)modelHasManualTransmission:(CarModel)model;

@end
