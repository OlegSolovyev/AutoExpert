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
    DSG,
    hydro,
    variator
} TranmissionType;

typedef enum{
    carburetor,
    injector
} InjectionType;

#define NUMBER_OF_MODELS 10

@interface AECarModel : NSObject

@property (nonatomic, retain) NSString *brand;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) int index;

@property (nonatomic) int minYear;
@property (nonatomic) int maxYear;

@property (nonatomic) BOOL injector;
@property (nonatomic) int injectorYear;
@property (nonatomic) BOOL carburetor;
@property (nonatomic) int carburetorYear;
@property (nonatomic) BOOL gasEngine;
@property (nonatomic) int gasEngineYear;
@property (nonatomic) BOOL dieselEngine;
@property (nonatomic) int dieselEngineYear;
@property (nonatomic) BOOL DSG;
@property (nonatomic) int DSGYear;
@property (nonatomic) BOOL hydroAutomatic;
@property (nonatomic) int hydroAutomaticYear;
@property (nonatomic) BOOL variatorTransmission;
@property (nonatomic) int variatorYear;
@property (nonatomic) BOOL manualTransmission;
@property (nonatomic) int manualTransmissionYear;

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
            variatorYear:(int)variatorYear;

@end
