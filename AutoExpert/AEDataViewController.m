//
//  AEDataViewController.m
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AEDataViewController.h"
#import "AEExpertSystem.h"
#import "AEUserDataManager.h"

@interface AEDataViewController ()

@end

@implementation AEDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self switchToSymptomCategorySelect];
    self.selectCounter = 0;
}

- (void)switchToSymptomCategorySelect{
    self.answers = [[NSMutableArray alloc] init];
    self.answers = [AESymptomDataBaseManager symptomCategoriesArray];
    [self.questionLabel setText:@"Выберите категорию"];
    self.currentState = symptomCategorySelect;
    [self.tableView reloadData];
}

- (void)switchToSymptomSelect{
    NSMutableArray *sypmtoms = [[AESymptomDataBaseManager sharedManager] symptomsForCategoryIndex:[[AEUserDataManager sharedManager] selectedSymptomCategoryIndex]];
    [self.questionLabel setText:@"Выберите симптом"];
    [self.answers removeAllObjects];
    for(AESymptom *symptom in sypmtoms){
        [self.answers addObject:symptom.name];
    }
    self.currentState = symptomSelect;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.answers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.answers objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectCounter++;
    int row = indexPath.row;
    
    switch (self.currentState) {
        case symptomCategorySelect:{
            [[AEUserDataManager sharedManager] setSelectedSymptomCategoryIndex:row];
            [self switchToSymptomSelect];
            break;
        }
        case symptomSelect:{
            [[AEUserDataManager sharedManager] setSelectedSymptom:[[AESymptomDataBaseManager sharedManager] symptomForName:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]]];
            [self finish];
            break;
        }
            
        default:
            break;
    }
}

- (void)finish{
    NSLog(@"Selected symptom : %@", [[[AEUserDataManager sharedManager] selectedSymptom] name]);
}

@end
