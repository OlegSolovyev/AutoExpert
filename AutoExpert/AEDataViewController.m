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
    symptomSelect
} state;

@interface AEDataViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic) state currentState;
@property (nonatomic, retain) NSMutableArray *answers;
@property (retain, nonatomic) NSMutableArray *searchResults;
@property (nonatomic) BOOL isSearching;
//@property (nonatomic) CGRect searchBarDefaultFrame;
@end

@implementation AEDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self switchToSymptomCategorySelect];
    self.searchResults = [[NSMutableArray alloc] init];
    [self.searchBar setShowsCancelButton:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Назад" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
}

- (void)backButtonAction:(id)sender{
    if (self.currentState == symptomCategorySelect) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self switchToSymptomCategorySelect];
    }
}

- (void)searchForSymptom:(NSString *)symptomString{
    [self.searchResults removeAllObjects];
    if(self.currentState == symptomCategorySelect){
        for(AESymptom *symptom in [[AESymptomDataBaseManager sharedManager] allSymptomsForCurrentCar]){
            NSString *name = [symptom.name capitalizedString];
            NSString *search = [symptomString capitalizedString];
            if([name rangeOfString:search].location != NSNotFound){
                [self.searchResults addObject:symptom.name];
            }
        }
    } else if(self.currentState == symptomSelect){
        for(AESymptom *symptom in [[AESymptomDataBaseManager sharedManager] symptomsForCategoryIndex:[[AEUserDataManager sharedManager] selectedSymptomCategoryIndex]]){
            NSString *name = [symptom.name capitalizedString];
            NSString *search = [symptomString capitalizedString];
            if([name rangeOfString:search].location != NSNotFound){
                [self.searchResults addObject:symptom.name];
            }
        }
    } else{
        NSLog(@"-searchForSymptom error: unhanled case");
    }
    NSLog(@"Search end %d", self.searchResults.count);
    [self.tableView reloadData];
}


/////////////////////

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text did change");
    //Remove all objects first.
    [self.searchResults removeAllObjects];
    
    if([searchText length] != 0) {
        self.isSearching = YES;
        [self searchForSymptom:searchBar.text];
    }
    else {
        self.isSearching = NO;
        [self.searchBar resignFirstResponder];
        NSLog(@"Nil text");
    }
}

- (void)setIsSearching:(BOOL)isSearching{
    _isSearching = isSearching;
    if(isSearching){
        [self.questionLabel setText:@"Результаты"];
        [self.searchBar setShowsCancelButton:YES];
    } else{
        if(self.currentState == symptomCategorySelect){
            [self.questionLabel setText:@"Выберите категорию"];
        } else{
            [self.questionLabel setText:@"Выберите неисправность"];
        }
        [self.searchBar setShowsCancelButton:NO];
    }
    [_tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
    [self.searchBar setText:@""];
    [self.searchResults removeAllObjects];
    [self.searchBar resignFirstResponder];
    self.isSearching = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchForSymptom:searchBar.text];
    [self.searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    NSLog(@"Should end editing");
    [searchBar resignFirstResponder];
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"Did end editing");
    [searchBar resignFirstResponder];
    if([searchBar.text isEqualToString:@""])self.isSearching = NO;
}

///////////////////////

- (void)switchToSymptomCategorySelect{
    self.answers = [[NSMutableArray alloc] init];
    for(NSString *category in [AESymptomDataBaseManager symptomCategoriesArray]){
        if([[AESymptomDataBaseManager sharedManager] symptomCategoryIsValidForCar:[AESymptomDataBaseManager symptomCategoryIndexForName:category]]){
            [self.answers addObject:category];
        }
    }
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
    int num = self.currentState == symptomCategorySelect ? 9 : 5;
    for (int i = 0; i < [self.answers count]; i ++) {
       if(i < num)tableHeight += [self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
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
    if(!self.isSearching){
        return [self.answers count];
    } else{
        return [self.searchResults count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isSearching){
        return 60.;
    } else{
        return (self.currentState == symptomCategorySelect) ? 40. : 70.;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"TableCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
        
        [[cell textLabel] setNumberOfLines:0]; // unlimited number of lines
        [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
        [[cell textLabel] setFont:[UIFont systemFontOfSize: 18.0]];
    }
    
    if(!self.isSearching){
        cell.textLabel.text = [self.answers objectAtIndex:indexPath.row];
    } else{
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.selectCounter++;
    int row = indexPath.row;
    if(!self.isSearching){
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
    } else{
            [[AEUserDataManager sharedManager] setSelectedSymptom:[[AESymptomDataBaseManager sharedManager] symptomForName:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]]];
            [self finish];
    }
}

- (void)finish{
    NSString * storyboardName = @"Main_iPhone";
    NSString * viewControllerID = @"Questions";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    AEQuestionsViewController *controller = (AEQuestionsViewController *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    [self.searchBar resignFirstResponder];
    [self.searchBar setText:@""];
    self.isSearching = NO;
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"Selected symptom : %@", [[[AEUserDataManager sharedManager] selectedSymptom] name]);
}

@end
