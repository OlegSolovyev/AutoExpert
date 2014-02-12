//
//  AEUserDataManager.m
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AEUserDataManager.h"

static AEUserDataManager *sharedDataManager = nil;

@implementation AEUserDataManager

+ (id)sharedManager {
    if(sharedDataManager == nil)
        sharedDataManager = [[AEUserDataManager alloc] init];
    return sharedDataManager;
}

+ (void)setDefaultData{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *UDtemp = [NSString stringWithFormat:@"%d", 0];
    [defaults setObject:UDtemp forKey:@"maxBonusScore"];

    [defaults setObject:[NSString stringWithFormat:@"%d",1] forKey:@"launchCounter"];
    
    [defaults synchronize];
    NSLog(@"Default stats saved");
    
}



+ (void)saveData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *UDtemp = [NSString stringWithFormat: @"%d", [[AEUserDataManager sharedManager] maxBonusScore]];
//    [defaults setObject:UDtemp forKey:@"maxBonusScore"];
    
    [defaults synchronize];
    NSLog(@"Data saved");
}

+ (void)loadData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    self.maxBonusScore = [[defaults objectForKey:@"maxBonusScore"] intValue];

    
    NSLog(@"Stats loaded");
}


- (id)init {
    if(sharedDataManager){
        return sharedDataManager;
    } else {
        if(self = [super init]){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([defaults objectForKey:@"launchCounter"]){
                [[AEUserDataManager sharedManager] loadData];
                [defaults setObject:[NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@",[defaults objectForKey:@"launchСounter" ]] intValue] + 1] forKey:@"launchCounter"];
                
            } else {
                [AEUserDataManager setDefaultData];
                
                [[AEUserDataManager sharedManager] loadData];
            }
            
        }
    }
    
    sharedDataManager = self;
    return sharedDataManager;
}


@end
