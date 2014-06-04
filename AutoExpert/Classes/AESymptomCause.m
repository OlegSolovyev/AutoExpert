//
//  AESymptomCause.m
//  AutoExpert
//
//  Created by Solo on 5/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AESymptomCause.h"

#define CAUSE_TAG_AKPP @"АКПП"
#define CAUSE_TAG_RKPP @"РКПП"
#define CAUSE_TAG_VARIATOR @"Вариатор"
#define CAUSE_TAG_INJECTOR @"Инжектор"
#define CAUSE_TAG_CARBURETOR @"Карбюратор"
#define CAUSE_TAG_GAS_ENGINE @"Бензин"
#define CAUSE_TAG_DIESEL_ENGINE @"Дизель"

@implementation AESymptomCause
- (id)initWithName:(NSString *)name
              tags:(NSArray *)tags
           factors:(NSArray *)factors
       probability:(int)probability
              link:(int)link{
    if(self = [super init]){
        self.name = name;
        self.probability = probability;
        self.link = link;
        
        self.automaticTransmission = FALSE;
        self.variatorTransmission = FALSE;
        self.manualTransmission = FALSE;
        self.gasEngine = FALSE;
        self.dieselEngine = FALSE;
        self.injector = FALSE;
        self.carburetor = FALSE;
        
        self.tags = tags;
        self.factors = factors;
        for(NSString *factor in factors){
            NSLog(@"Factor: %@", factor);
        }
        
        if(tags){
            for(NSString *tag in tags){
//                NSLog(@"TAG %@",tag);
                if([tag isEqualToString:CAUSE_TAG_AKPP]){
                    self.automaticTransmission = TRUE;
                } else if([tag isEqualToString:CAUSE_TAG_RKPP]){
                    self.manualTransmission = TRUE;
                } else if([tag isEqualToString:CAUSE_TAG_VARIATOR]){
                    self.variatorTransmission = TRUE;
                } else if([tag isEqualToString:CAUSE_TAG_INJECTOR]){
                    self.injector = TRUE;
                } else if([tag isEqualToString:CAUSE_TAG_CARBURETOR]){
                    self.carburetor = TRUE;
                } else if([tag isEqualToString:CAUSE_TAG_GAS_ENGINE]){
                    self.gasEngine = TRUE;
                } else if([tag isEqualToString:CAUSE_TAG_DIESEL_ENGINE]){
                    self.dieselEngine = TRUE;
                }
            }
        }

    }
    
    return  self;
}

- (NSComparisonResult)compareProbability:(AESymptomCause *)otherObject{
    if(self.probability > otherObject.probability){
        return NSOrderedAscending;
    } else if(self.probability < otherObject.probability){
        return NSOrderedDescending;
    }else return NSOrderedSame;
}

- (NSComparisonResult)compareLink:(AESymptomCause *)otherObject{
    if(self.link > otherObject.link){
        return NSOrderedDescending;
    } else if(self.link < otherObject.link){
        return NSOrderedAscending;
    }else return NSOrderedSame;
}

@end
