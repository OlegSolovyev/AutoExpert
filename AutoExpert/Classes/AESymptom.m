//
//  AESymptom.m
//  AutoExpert
//
//  Created by Solo on 5/25/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AESymptom.h"
#import "AECarsDataBaseManager.h"

@implementation AESymptom
- (id)initWithName:(NSString *)name
             index:(int)index
     categoryIndex:(SymptomCategoryIndex)categoryIndex
            causes:(NSArray *)causes
            models:(NSArray *)models{
    if(self = [super init]){
        self.name = name;
        self.index = index;
        self.categoryIndex = categoryIndex;
        self.causes = [causes sortedArrayUsingSelector:@selector(compareProbability:)];
        self.causes = [causes sortedArrayUsingSelector:@selector(compareLink:)];
        if([models[0] isEqualToString:@"All"]){
            self.models = [[AECarsDataBaseManager sharedManager] models];
//            for(AECarModel *model in self.models){
//                NSLog(@"MODEL: %@", model.name);
//            }
        } else{
            self.models = models;
        }
//        for(AESymptomCause *cause in self.causes){
//            NSLog(@"%@",cause.name);
//        }

    }
    
    return  self;
}

//- (id)copyWithZone:(NSZone *)zone
//{
//    id copy = [[[self class] alloc] init];
//    
//    if (copy)
//    {
//        // Copy NSObject subclasses
//        [copy setName:[self.name copyWithZone:zone]];
//        [copy setCauses:[self.causes copyWithZone:zone]];
//        [copy setModels:[self.models copyWithZone:zone]];
//        
//        // Set primitives
//        [copy setIndex:self.index];
//        [copy setCategoryIndex:self.categoryIndex];
//    }
//    
//    return copy;
//}

@end
