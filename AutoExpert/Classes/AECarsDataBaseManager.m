//
//  AECarsDataBaseManager.m
//  AutoExpert
//
//  Created by Oleg Solovyev on 17/03/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AECarsDataBaseManager.h"

static AECarsDataBaseManager *sharedDataManager = nil;

@implementation AECarsDataBaseManager

+ (id)sharedManager {
    if(sharedDataManager == nil)
        sharedDataManager = [[AECarsDataBaseManager alloc] init];
    return sharedDataManager;
}

- (id)init{
    if( self = [super init]){
        self.models = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadModels{
    NSLog(@"Loading models database..");
    self.models = [[NSMutableArray alloc] init];
    
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ModelsBase" ofType:@"txt"];
    if ([filemgr fileExistsAtPath: path ] == YES)
        //        NSLog (@"File exists %@", path );
        ;
    else
        NSLog (@"File not found");
    
    NSString *dataBase = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings = [dataBase componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for(int i = 0; i < [allLinedStrings count]; i++){
        if([[allLinedStrings objectAtIndex:i] isEqualToString:@"Model"]){
            int index = [[allLinedStrings objectAtIndex:i + 2] intValue];
     NSLog(@"index : %d", index);
            NSString *brand = [allLinedStrings objectAtIndex:i + 4];
            NSLog(@"Brand %@", brand);
            NSString *name = [allLinedStrings objectAtIndex:i + 6];
        NSLog(@"Name : %@",name);
            
            int minYear = [[allLinedStrings objectAtIndex:i + 8] intValue];
            int maxYear = [[allLinedStrings objectAtIndex:i + 10] intValue];
            
            NSLog(@"Years: %d - %d", minYear, maxYear);
            

            
            BOOL diesel = [[[[allLinedStrings objectAtIndex:i + 12] componentsSeparatedByString:@";"] objectAtIndex:0] intValue];
            NSLog(@"%@ Diesel %d", [allLinedStrings objectAtIndex:i + 12], diesel);
            int dieselYear = [[[[allLinedStrings objectAtIndex:i + 12] componentsSeparatedByString:@";"] objectAtIndex:1] intValue];
            NSLog(@"Diesel year %d", dieselYear);
            BOOL gas = [[[[allLinedStrings objectAtIndex:i + 14] componentsSeparatedByString:@";"] objectAtIndex:0] intValue];
            int gasYear = [[[[allLinedStrings objectAtIndex:i + 14] componentsSeparatedByString:@";"] objectAtIndex:1] intValue];
            BOOL injector = [[[[allLinedStrings objectAtIndex:i + 16] componentsSeparatedByString:@";"] objectAtIndex:0] intValue];
            int injectorYear = [[[[allLinedStrings objectAtIndex:i + 16] componentsSeparatedByString:@";"] objectAtIndex:1] intValue];
            BOOL carburetor = [[[[allLinedStrings objectAtIndex:i + 18] componentsSeparatedByString:@";"] objectAtIndex:0] intValue];
            int carburetorYear = [[[[allLinedStrings objectAtIndex:i + 18] componentsSeparatedByString:@";"] objectAtIndex:1] intValue];
            BOOL manual = [[[[allLinedStrings objectAtIndex:i + 20] componentsSeparatedByString:@";"] objectAtIndex:0] intValue];
            int manualYear = [[[[allLinedStrings objectAtIndex:i + 20] componentsSeparatedByString:@";"] objectAtIndex:1] intValue];
            BOOL DSG = [[[[allLinedStrings objectAtIndex:i + 22] componentsSeparatedByString:@";"] objectAtIndex:0] intValue];
            int DSGYear = [[[[allLinedStrings objectAtIndex:i + 22] componentsSeparatedByString:@";"] objectAtIndex:1] intValue];
            BOOL hydro = [[[[allLinedStrings objectAtIndex:i + 24] componentsSeparatedByString:@";"] objectAtIndex:0] intValue];
            int hydroYear = [[[[allLinedStrings objectAtIndex:i + 24] componentsSeparatedByString:@";"] objectAtIndex:1] intValue];
            BOOL variator = [[[[allLinedStrings objectAtIndex:i + 26] componentsSeparatedByString:@";"] objectAtIndex:0] intValue];
            int variatorYear = [[[[allLinedStrings objectAtIndex:i + 26] componentsSeparatedByString:@";"] objectAtIndex:1] intValue];
            
            [self.models addObject:[[AECarModel alloc] initWithModelIndex:index brand:brand name:name minYear:minYear maxYear:maxYear injector:injector injectorYear:injectorYear carburetor:carburetor carburetorYear:carburetorYear gasEngine:gas gasEngineYear:gasYear dieselEngine:diesel dieselEngineYear:dieselYear manualTransmission:manual manualTransmissionYear:manualYear DSG:DSG DSGYear:DSGYear hydroAutomatic:hydro hydroAutomaticYear:hydroYear variator:variator variatorYear:variatorYear]];
            i += 26;
        }
        
    }
    
    NSLog(@"Models loaded");

}

@end
