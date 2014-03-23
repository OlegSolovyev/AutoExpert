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
        
    }
    return self;
}

- (NSMutableArray *)getCarsArray{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    
    return result;
}

@end
