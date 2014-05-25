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
        self.causes = causes;
        if([models[0] isEqualToString:@"All"]){
            self.models = [[AECarsDataBaseManager sharedManager] modelsArray];
        } else{
            self.models = models;
        }

    }
    
    return  self;
}
@end
