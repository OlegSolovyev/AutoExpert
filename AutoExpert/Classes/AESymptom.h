//
//  AESymptom.h
//  AutoExpert
//
//  Created by Solo on 5/25/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AESymptomSpecification.h"
#import "AESymptomCause.h"

@interface AESymptom : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic) int index;
@property (nonatomic) SymptomCategoryIndex categoryIndex;
@property (nonatomic, retain) NSArray *causes;
@property (nonatomic, retain) NSArray *models;

- (id)initWithName:(NSString *)name
             index:(int)index
     categoryIndex:(SymptomCategoryIndex)categoryIndex
            causes:(NSArray *)causes
            models:(NSArray *)models;

@end
