//
//  AEUserDataManager.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AECar.h"

@interface AEUserDataManager : NSObject

+ (id)sharedManager;
+ (void)loadData;
+ (void)saveData;

- (void)setSelectedCarByName:(NSString *)name year:(int)year;
@property (nonatomic, retain) AECar *selectedCar;

@end

