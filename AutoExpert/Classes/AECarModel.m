//
//  AECarModel.m
//  AutoExpert
//
//  Created by Oleg Solovyev on 27/03/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AECarModel.h"
#import "AECarsDataBaseManager.h"

@implementation AECarModel
- (id)initWithModelIndex:(CarModelIndex)modelIndex{
    if(self = [super init]){
        self.index = modelIndex;
        self.name = [AECarsDataBaseManager stringForModelIndex:modelIndex];
        self.minYear = [AECarsDataBaseManager minYearForModelIndex:modelIndex];
        self.maxYear = [AECarsDataBaseManager maxYearForModelIndex:modelIndex];
        
        self.injector = [AECarsDataBaseManager modelHasInjector:modelIndex];
        self.carburetor = [AECarsDataBaseManager modelHasCarburetor:modelIndex];
        self.gasEngine = [AECarsDataBaseManager modelHasGasEngine:modelIndex];
        self.dieselEngine = [AECarsDataBaseManager modelHasDieselEngine:modelIndex];
        self.automaticTransmission = [AECarsDataBaseManager modelHasAutomaticTransmission:modelIndex];
        self.manualTransmission = [AECarsDataBaseManager modelHasManualTransmission:modelIndex];
    }
    return self;
}

@end
