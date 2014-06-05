//
//  AESymptomCause.m
//  AutoExpert
//
//  Created by Solo on 5/26/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AESymptomCause.h"
#import "AEUserDataManager.h"

#define CAUSE_TAG_AKPP @"АКПП"
#define CAUSE_TAG_RKPP @"РКПП"
#define CAUSE_TAG_VARIATOR @"Вариатор"
#define CAUSE_TAG_INJECTOR @"Инжектор"
#define CAUSE_TAG_CARBURETOR @"Карбюратор"
#define CAUSE_TAG_GAS_ENGINE @"Бензин"
#define CAUSE_TAG_DIESEL_ENGINE @"Дизель"

#define CAUSE_FACTOR_WAY @"Пробег"
#define CAUSE_FACTOR_WAY_SINCE_SERVICE @"ТО"
#define CAUSE_FACTOR_YEAR @"Год"

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
        if(factors){
            for(NSString *factor in factors){
                if([factor isEqualToString:CAUSE_FACTOR_WAY]){
                    self.probability = self.probability * [[[AEUserDataManager sharedManager] currentCar] distance] / 200000.;
                } else if([factor isEqualToString:CAUSE_FACTOR_WAY_SINCE_SERVICE]){
                    self.probability = self.probability * [[[AEUserDataManager sharedManager] currentCar] distanceSinceService] / 15000.;
                } else if([factor isEqualToString:CAUSE_FACTOR_YEAR]){
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy"];
                    NSString *yearString = [formatter stringFromDate:[NSDate date]];
                    
                    self.probability = self.probability * ([yearString intValue] - [[[AEUserDataManager sharedManager] currentCar] year]) / 20;
                } else{
                    NSLog(@"ERROR: Unknown factor");
                }
            }
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
                } else{
                    NSLog(@"ERROR: Unknown tag");
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
