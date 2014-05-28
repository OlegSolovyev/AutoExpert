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

+ (NSString *)stringForModelIndex:(CarModelIndex)modelIndex;
+ (CarModelIndex)modelIndexForString:(NSString *)string;

+ (int)minYearForModelIndex:(CarModelIndex)modelIndex;
+ (int)maxYearForModelIndex:(CarModelIndex)modelIndex;

+ (BOOL)modelHasInjector:(CarModelIndex)modelIndex;
+ (BOOL)modelHasCarburetor:(CarModelIndex)modelIndex;
+ (BOOL)modelHasGasEngine:(CarModelIndex)modelIndex;
+ (BOOL)modelHasDieselEngine:(CarModelIndex)modelIndex;
+ (BOOL)modelHasAutomaticTransmission:(CarModelIndex)modelIndex;
+ (BOOL)modelHasVariatorTransmission:(CarModelIndex)modelIndex;
+ (BOOL)modelHasManualTransmission:(CarModelIndex)modelIndex;

@property (nonatomic, retain) NSMutableArray *modelsArray;

@end
