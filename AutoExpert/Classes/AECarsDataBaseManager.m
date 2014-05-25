//
//  AECarsDataBaseManager.m
//  AutoExpert
//
//  Created by Oleg Solovyev on 17/03/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AECarsDataBaseManager.h"

static AECarsDataBaseManager *sharedDataManager = nil;

@implementation AECarsDataBaseManager

+ (id)sharedManager {
    if(sharedDataManager == nil)
        sharedDataManager = [[AECarsDataBaseManager alloc] init];
    return sharedDataManager;
}

- (id)init{
    if( self = [super init]){
        self.modelsArray = [[NSMutableArray alloc] init];
        for(int i = 0; i < NUMBER_OF_MODELS; ++i){
            [self.modelsArray addObject:[AECarsDataBaseManager stringForModelIndex:i]];
        }
    }
    return self;
}

+ (CarModelIndex)modelIndexForString:(NSString *)string{
    CarModelIndex result = 0;
    for(int i = 0; i < NUMBER_OF_MODELS; ++i){
        if([string isEqualToString:[AECarsDataBaseManager stringForModelIndex:i]]){
            result = i;
        }
    }
    return result;
}

+ (NSString *)stringForModelIndex:(CarModelIndex)modelIndex{
    NSString *result;
    switch (modelIndex) {
        case vaz2101:
            result = [NSString stringWithFormat:@"ВАЗ 2101"];
            break;
        case vaz2102:
            result = [NSString stringWithFormat:@"ВАЗ 2102"];
            break;
        case vaz2103:
            result = [NSString stringWithFormat:@"ВАЗ 2103"];
            break;
        case vaz2104:
            result = [NSString stringWithFormat:@"ВАЗ 2104"];
            break;
        case vaz2105:
            result = [NSString stringWithFormat:@"ВАЗ 2105"];
            break;
        case vaz2106:
            result = [NSString stringWithFormat:@"ВАЗ 2106"];
            break;
        case vaz2107:
            result = [NSString stringWithFormat:@"ВАЗ 2107"];
            break;
        case vaz2108:
            result = [NSString stringWithFormat:@"ВАЗ 2108"];
            break;
        case vaz2109:
            result = [NSString stringWithFormat:@"ВАЗ 2109"];
            break;
        case vaz2110:
            result = [NSString stringWithFormat:@"ВАЗ 2110"];
            break;
            
        default:
            break;
    }
    return result;
}

+ (int)minYearForModelIndex:(CarModelIndex)modelIndex{
    int result = 0;
    switch (modelIndex) {
        case vaz2101:
            result = 1970;
            break;
        case vaz2102:
            result = 1971;
            break;
        case vaz2103:
            result = 1973;
            break;
        case vaz2104:
            result = 1984;
            break;
        case vaz2105:
            result = 1979;
            break;
        case vaz2106:
            result = 1976;
            break;
        case vaz2107:
            result = 1982;
            break;
        case vaz2108:
            result = 1984;
            break;
        case vaz2109:
            result = 1987;
            break;
        case vaz2110:
            result = 1995;
            break;
            
        default:
            break;
    }
    return result;
}

+ (int)maxYearForModelIndex:(CarModelIndex)modelIndex{
    int result = 0;
    switch (modelIndex) {
        case vaz2101:
            result = 1988;
            break;
        case vaz2102:
            result = 1985;
            break;
        case vaz2103:
            result = 1984;
            break;
        case vaz2104:
            result = 2012;
            break;
        case vaz2105:
            result = 2010;
            break;
        case vaz2106:
            result = 2006;
            break;
        case vaz2107:
            result = 2012;
            break;
        case vaz2108:
            result = 2003;
            break;
        case vaz2109:
            result = 2011;
            break;
        case vaz2110:
            result = 2007;
            break;
            
        default:
            break;
    }
    return result;
}

+ (BOOL)modelHasInjector:(CarModelIndex)modelIndex{
    BOOL result = 0;
    switch (modelIndex) {
        case vaz2101:
            result = NO;
            break;
        case vaz2102:
            result = NO;
            break;
        case vaz2103:
            result = NO;
            break;
        case vaz2104:
            result = YES;
            break;
        case vaz2105:
            result = YES;
            break;
        case vaz2106:
            result = NO;
            break;
        case vaz2107:
            result = YES;
            break;
        case vaz2108:
            result = YES;
            break;
        case vaz2109:
            result = YES;
            break;
        case vaz2110:
            result = YES;
            break;
            
        default:
            break;
    }
    return result;
}
+ (BOOL)modelHasCarburetor:(CarModelIndex)modelIndex{
    return YES;
}
+ (BOOL)modelHasGasEngine:(CarModelIndex)modelIndex{
    return YES;
}
+ (BOOL)modelHasDieselEngine:(CarModelIndex)modelIndex{
    return NO;
}
+ (BOOL)modelHasAutomaticTransmission:(CarModelIndex)modelIndex{
    return NO;
}
+ (BOOL)modelHasManualTransmission:(CarModelIndex)modelIndex{
    return YES;
}

@end
