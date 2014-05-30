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

@interface AEDataViewController () <UISearchDisplayDelegate, UISearchBarDelegate>
@property (nonatomic) state currentState;
@property (retain, nonatomic) NSMutableArray *searchResults;
@property (nonatomic) CGRect searchBarDefaultFrame;
@end

@implementation AEDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self switchToSymptomCategorySelect];
    self.searchResults = [[NSMutableArray alloc] init];
    [self.searchDisplayController.searchBar setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y - self.searchDisplayController.searchBar.frame.size.height, self.tableView.frame.size.width, self.searchDisplayController.searchBar.frame.size.height)];
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (osVersion >= 7.0)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
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
                NSLog(@"++");
            }
        }
    } else{
        NSLog(@"-searchForSymptom error: unhanled case");
    }
    NSLog(@"Search end %d", self.searchResults.count);
}


/////////////////////

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        controller.searchResultsTableView.frame = self.tableView.frame;
        [controller.searchContentsController.view setNeedsLayout];
    }
    [self searchForSymptom:searchString];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

static UIView *PSPDFViewWithSuffix(UIView *view, NSString *classNameSuffix) {
    if (!view || classNameSuffix.length == 0) return nil;
    
    UIView *theView = nil;
    for (__unsafe_unretained UIView *subview in view.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:classNameSuffix]) {
            return subview;
        }else {
            if ((theView = PSPDFViewWithSuffix(subview, classNameSuffix))) break;
        }
    }
    return theView;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {
    // HACK: iOS 7 requires a cruel workaround to show the search table view.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        controller.searchResultsTableView.contentInset = UIEdgeInsetsMake(self.searchDisplayController.searchBar.frame.size.height, 0.f, 0.f, 0.f);
    }
//    tableView.frame = self.tableView.frame;
}

- (void)correctSearchDisplayFrames {
    // Update search bar frame.
    CGRect superviewFrame = self.searchDisplayController.searchBar.superview.frame;
    superviewFrame.origin.y = 0.f;
    self.searchDisplayController.searchBar.superview.frame = superviewFrame;
    
    // Strech dimming view.
    UIView *dimmingView = PSPDFViewWithSuffix(self.view, @"DimmingView");
    if (dimmingView) {
        CGRect dimmingFrame = dimmingView.superview.frame;
        dimmingFrame.origin.y = self.searchDisplayController.searchBar.frame.size.height;
        dimmingFrame.size.height = self.view.frame.size.height - dimmingFrame.origin.y;
        dimmingView.superview.frame = dimmingFrame;
    }
}

- (void)setAllViewsExceptSearchHidden:(BOOL)hidden animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.25f : 0.f animations:^{
        for (UIView *view in self.tableView.subviews) {
            if (view != self.searchDisplayController.searchResultsTableView &&
                view != self.searchDisplayController.searchBar) {
                view.alpha = hidden ? 0.f : 1.f;
            }
        }
    }];
}

// This fixes UISearchBarController on iOS 7. rdar://14800556
- (void)correctFramesForSearchDisplayControllerBeginSearch:(BOOL)beginSearch {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [self.navigationController setNavigationBarHidden:beginSearch animated:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self correctSearchDisplayFrames];
        });
        [self setAllViewsExceptSearchHidden:beginSearch animated:YES];
        [UIView animateWithDuration:0.25f animations:^{
            self.searchDisplayController.searchResultsTableView.alpha = beginSearch ? 1.f : 0.f;
        }];
    }
}


- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    [self correctFramesForSearchDisplayControllerBeginSearch:YES];
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    [self correctSearchDisplayFrames];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    [self correctFramesForSearchDisplayControllerBeginSearch:NO];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 70.;
}

////////////////////////////////

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
    if(tableView == self.tableView){
        return [self.answers count];
    } else{
        return [self.searchResults count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.currentState == symptomCategorySelect) ? 40. : 70.;
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
    
    if(tableView == self.tableView){
        cell.textLabel.text = [self.answers objectAtIndex:indexPath.row];
    } else{
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.selectCounter++;
    int row = indexPath.row;
    if(tableView == self.tableView){
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
//    [self pushViewController:controller animated:NO completion:nil];
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"Selected symptom : %@", [[[AEUserDataManager sharedManager] selectedSymptom] name]);
}

@end
