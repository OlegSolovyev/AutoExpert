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

- (id)initWithModelIndex:(int)modelIndex
                   brand:(NSString *)brand
                    name:(NSString *)name
                 minYear:(int)minYear
                 maxYear:(int)maxYear
                injector:(BOOL)injector
            injectorYear:(int)injectorYear
              carburetor:(BOOL)carburetor
          carburetorYear:(int)carburetorYear
               gasEngine:(BOOL)gasEngine
           gasEngineYear:(int)gasEngineYear
            dieselEngine:(BOOL)dieselEngine
        dieselEngineYear:(int)dieselEngineYear
      manualTransmission:(BOOL)manualTransmission
  manualTransmissionYear:(int)manualTransmissionYear
                     DSG:(BOOL)DSG
                 DSGYear:(int)DSGYear
          hydroAutomatic:(BOOL)hydroAutomatic
      hydroAutomaticYear:(int)hydroAutomaticYear
                variator:(BOOL)variator
            variatorYear:(int)variatorYear{
    if(self = [super init]){
        
        self.index = modelIndex;
        self.brand = brand;
        self.name = name;
        self.minYear = minYear;
        self.maxYear = maxYear;
        self.injector = injector;
        self.injectorYear = (injectorYear != 0) ? injectorYear : minYear;
        self.carburetor = carburetor;
        self.carburetorYear = (carburetorYear != 0) ? carburetorYear : minYear;
        self.gasEngine = gasEngine;
        self.gasEngineYear = (gasEngineYear != 0) ? gasEngineYear : minYear;
        self.dieselEngine = dieselEngine;
        self.dieselEngineYear = (dieselEngineYear != 0) ? dieselEngineYear : minYear;
        self.DSG = DSG;
        self.DSGYear = (DSGYear != 0) ? DSGYear : minYear;
        self.hydroAutomatic = hydroAutomatic;
        self.hydroAutomaticYear = (hydroAutomaticYear!= 0) ? hydroAutomaticYear : minYear;
        self.variatorTransmission = variator;
        self.variatorYear = (variatorYear != 0) ? variatorYear  : minYear;
        self.manualTransmission = manualTransmission;
        self.manualTransmissionYear = (manualTransmissionYear != 0) ? manualTransmissionYear  : minYear;
    }
    return self;
}

@end
