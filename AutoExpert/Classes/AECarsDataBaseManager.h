//
//  AECarsDataBaseManager.h
//  AutoExpert
//
//  Created by Oleg Solovyev on 17/03/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AECarsDataBaseManager : NSObject

+ (id)sharedManager;
- (NSMutableArray *)getCarsArray;

@end
