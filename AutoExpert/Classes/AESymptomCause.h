//
//  AESymptomCause.h
//  AutoExpert
//
//  Created by Solo on 5/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESymptomCause : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *tags;

@property (nonatomic) BOOL injector;
@property (nonatomic) BOOL carburetor;
@property (nonatomic) BOOL gasEngine;
@property (nonatomic) BOOL dieselEngine;
@property (nonatomic) BOOL automaticTransmission;
@property (nonatomic) BOOL manualTransmission;

- (id)initWithName:(NSString *)name
              tags:(NSArray *)tags;

@end
