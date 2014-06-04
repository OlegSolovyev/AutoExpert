//
//  AESymptomDataBaseManager.m
//  AutoExpert
//
//  Created by Solo on 5/25/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AESymptomDataBaseManager.h"
#import "AEUserDataManager.h"

#define NEW_SYPMTOM_STRING @"Symptom"
#define SYMPTOM_INDEX_STRING @"Index:"
#define SYMPTOM_CATEGORY_STRING @"Category:"
#define SYMPTOM_NAME_STRING @"Name:"
#define SYMPTOM_CAUSES_STRING @"Causes:"
#define SYMPTOM_MODELS_STRING @"Models:"

#define SEPARATOR @";"




static AESymptomDataBaseManager *sharedDataManager = nil;

@implementation AESymptomDataBaseManager
+ (id)sharedManager {
    if(sharedDataManager == nil)
        sharedDataManager = [[AESymptomDataBaseManager alloc] init];
    return sharedDataManager;
}

- (id)init{
    if( self = [super init]){
        [self loadSymptoms];
    }
    return self;
}

- (void)loadSymptoms{
    NSLog(@"Loading symptoms database..");
    self.symptoms = [[NSMutableArray alloc] init];
    
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SymptomsDataBase" ofType:@"txt"];
    if ([filemgr fileExistsAtPath: path ] == YES)
//        NSLog (@"File exists %@", path );
        ;
    else
        NSLog (@"File not found");
    
    NSString *dataBase = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    NSArray* allLinedStrings = [dataBase componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for(int i = 0; i < [allLinedStrings count]; i++){
        if([[allLinedStrings objectAtIndex:i] isEqualToString:NEW_SYPMTOM_STRING]){
            int index = [[allLinedStrings objectAtIndex:i + 2] intValue];
//            NSLog(@"index : %d", index);
            int categoryIndex = [AESymptomDataBaseManager symptomCategoryIndexForName:[allLinedStrings objectAtIndex:i + 4]];
            NSLog(@"Category : %d(%@)", categoryIndex, [allLinedStrings objectAtIndex:i + 4]);
            NSString *name = [allLinedStrings objectAtIndex:i + 6];
//            NSLog(@"Name : %@",name);
            NSMutableArray *causes = [[NSMutableArray alloc] init];
            
            int j = i + 8;
            
            NSArray *firstSeparation = [[NSArray alloc] initWithObjects:@"", nil];
            NSArray *causeString = [[NSArray alloc] initWithObjects:@"", nil];
            do{
                firstSeparation = [[allLinedStrings objectAtIndex:j] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"&"]];
                causeString = [[firstSeparation objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:SEPARATOR]];
                if(![causeString[0] isEqualToString:SYMPTOM_MODELS_STRING]){
                    NSArray *dev = [[causeString objectAtIndex:0] componentsSeparatedByString:@":"];
                    NSString *causeName = dev[0];
//                    NSLog(@"Loading cause name: %@", causeName);
                    if([dev count] > 1){
                        dev = [[dev objectAtIndex:1] componentsSeparatedByString:@"$"];
                    } else NSLog(@"ERROR: no ':' in cause %@", causeString[j]);
                    int causeProbability = [dev[0] intValue];
//                    NSLog(@"Loading cause probability: %d", causeProbability);
                    int link;
                    if([dev count] > 1){
                        link = [dev[1] intValue];
//                        NSLog(@"Loading cause index: %d", index);
                    } else NSLog(@"ERROR: no '$' in cause %@", causeString[j]);
                    NSMutableArray *tags = [[NSMutableArray alloc] init];
                    NSMutableArray *factors = [[NSMutableArray alloc] init];
                    if(causeString.count > 1){
                        for(int k = 1; k < causeString.count; ++k){
                                [tags addObject:[causeString objectAtIndex:k]];
                        }
                    } else{
                        tags = nil;
                    }
                    
                    if(firstSeparation.count > 1){
                            for(int l = 1; l < firstSeparation.count; ++l){
                                [factors addObject:[firstSeparation objectAtIndex:l]];
                            }
                    } else{
                        factors = nil;
                    }
                        [causes addObject:[[AESymptomCause alloc] initWithName:causeName
                                                                          tags:tags
                                                                       factors:factors
                                                                   probability:causeProbability
                                                                 link:link]];
                
                }
                j++;
            } while (![[causeString objectAtIndex:0] isEqualToString:SYMPTOM_MODELS_STRING]);
//            NSLog(@"Causes Loaded");
            
            
            NSArray *models = [[allLinedStrings objectAtIndex:j] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:SEPARATOR]];
            
            [self.symptoms addObject:[[AESymptom alloc] initWithName:name
                                                               index:index
                                                       categoryIndex:categoryIndex
                                                              causes:causes
                                                              models:models]];
            i = j + 1;
        }
    }
    
    NSLog(@"Symptoms loaded");
}

+ (SymptomCategoryIndex)symptomCategoryIndexForName:(NSString *)name{
    SymptomCategoryIndex result = 0;
    for(int i = 0; i < NUMBER_OF_SYMPTOM_CATEGORIES; ++i){
        if([name isEqualToString:[AESymptomDataBaseManager nameForSymptomCategoryIndex:i]]){
            result = i;
        }
    }
    return result;
}

+ (NSString *)nameForSymptomCategoryIndex:(SymptomCategoryIndex)symptomCategoryIndex{
    NSString *result;
    switch (symptomCategoryIndex) {
        case common:
            result = @"Общее";
            break;
        case engine:
            result = @"Двигатель";
            break;
        case coolingSystem:
            result = @"Система охлаждения";
            break;
        case fuelSystem:
            result = @"Топливная система";
            break;
        case clutch:
            result = @"Сцепление";
            break;
        case transmission:
            result = @"Коробка передач";
            break;
        case suspension:
            result = @"Шины и подвеска";
            break;
        case steering:
            result = @"Рулевое управление";
            break;
        case breaking:
            result = @"Тормозная система";
            break;
        case carburetorCategory:
            result = @"Карбюратор";
            break;
        case starter:
            result = @"Стартер";
            break;
        case exhaustRecirculation:
            result = @"РОГ";
            break;
        case ignition:
            result = @"Зажигание";
            break;
            
        default:
            break;
    }
    return result;
}

+ (NSMutableArray *)symptomCategoriesArray{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(int i = 0; i < NUMBER_OF_SYMPTOM_CATEGORIES; ++i){
        [result addObject:[AESymptomDataBaseManager nameForSymptomCategoryIndex:i]];
    }
    return result;
}

- (NSMutableArray *)symptomsForCategoryIndex:(SymptomCategoryIndex)index{
    NSLog(@"Symptoms for category index %d",index);
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(AESymptom *symptom in self.symptoms){
        if(symptom.categoryIndex == index){
            [result addObject:symptom];
        }
    }
    return result;
}

- (AESymptom *)symptomForIndex:(int)index{
    AESymptom *result;
    for(AESymptom *symptom in self.symptoms){
        if(symptom.index == index){
            result = symptom;
        }
    }
    return result;
}

- (AESymptom *)symptomForName:(NSString *)name{
    for (AESymptom *symptom in self.symptoms){
        if([symptom.name isEqualToString:name]){
            return symptom;
        }
    }
    NSLog(@"-symptomForName ERROR: symptom '%@' not found", name);
    return nil;
}

- (BOOL)symptomCategoryIsValidForCar:(SymptomCategoryIndex)index{
    BOOL result = YES;
    switch (index) {
        case carburetorCategory:
            if([[[AEUserDataManager sharedManager] currentCar] injectionType] != carburetor){
                result = NO;
                NSLog(@"NO");
            }
            break;
        default:
            break;
            
    }
    return result;
}

- (NSMutableArray *)allSymptomsForCurrentCar{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSLog(@"-allSymptoms");
    for(AESymptom *symptom in self.symptoms){
        if([symptom.models containsObject:[[[[AEUserDataManager sharedManager] currentCar] model] name]]
           && [self symptomCategoryIsValidForCar:symptom.categoryIndex]){
            [result addObject:symptom];
        }
    }
    return result;
}

@end
