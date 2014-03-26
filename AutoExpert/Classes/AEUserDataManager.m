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

- (id)init {
    if(sharedDataManager){
        return sharedDataManager;
    } else {
        if(self = [super init]){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([defaults objectForKey:@"car"]){
                [[AEUserDataManager sharedManager] loadData];
                [defaults setObject:[NSString stringWithFormat:@"%d", [[NSString stringWithFormat:@"%@",[defaults objectForKey:@"car" ]] intValue] + 1] forKey:@"car"];
                
            }
            
        }
    }
    
    sharedDataManager = self;
    return sharedDataManager;
}

+ (id)sharedManager {
    if(sharedDataManager == nil)
        sharedDataManager = [[AEUserDataManager alloc] init];
    return sharedDataManager;
}

+ (void)saveData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults synchronize];
    NSLog(@"Data saved");
}

+ (void)loadData{
    
    NSLog(@"Data loaded");
}

- (void)setSelectedCarByName:(NSString *)name year:(int)year{
    
}




@end
