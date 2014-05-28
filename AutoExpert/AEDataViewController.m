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
#import "AEQuestionsViewController.h"

typedef enum{
    symptomCategorySelect,
    symptomSelect,
} state;

@interface AEDataViewController ()
@property (nonatomic) state currentState;
@end

@implementation AEDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self switchToSymptomCategorySelect];
    self.selectCounter = 0;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Назад" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
}

- (void)backButtonAction:(id)sender{
    if (self.currentState == symptomCategorySelect) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self switchToSymptomCategorySelect];
    }
}

- (void)switchToSymptomCategorySelect{
    self.answers = [[NSMutableArray alloc] init];
    self.answers = [AESymptomDataBaseManager symptomCategoriesArray];
    [self.questionLabel setText:@"Выберите категорию"];
    self.currentState = symptomCategorySelect;
    [self.tableView reloadData];
    [self resizeTableView];
}

- (void)switchToSymptomSelect{
    [self.questionLabel setText:@"Выберите симптом"];
    [self.answers removeAllObjects];
    NSString *modelName = [[[[AEUserDataManager sharedManager] currentCar] model] name];
    for(AESymptom *symptom in [[AESymptomDataBaseManager sharedManager] symptomsForCategoryIndex:[[AEUserDataManager sharedManager] selectedSymptomCategoryIndex]]){
        if([symptom.models containsObject:modelName]){
            [self.answers addObject:symptom.name];
        }
    }
    self.currentState = symptomSelect;
    [self.tableView reloadData];
    [self resizeTableView];
}

- (void)resizeTableView{
    CGFloat tableHeight = 0.0f;
    for (int i = 0; i < [self.answers count]; i ++) {
       if(i < 9)tableHeight += [self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, tableHeight);
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    NSString * storyboardName = @"Main_iPhone";
    NSString * viewControllerID = @"Questions";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    AEQuestionsViewController *controller = (AEQuestionsViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
//    [self pushViewController:controller animated:NO completion:nil];
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"Selected symptom : %@", [[[AEUserDataManager sharedManager] selectedSymptom] name]);
}

@end
