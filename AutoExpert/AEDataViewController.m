//
//  AEDataViewController.m
//  AutoExpert
//
//  Created by Oleg Solovyev on 03/02/14.
//  Copyright (c) 2014 Opensoft. All rights reserved.
//

#import "AEDataViewController.h"

@interface AEDataViewController ()

@end

@implementation AEDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     self.answers = [[NSMutableArray alloc] init];
    for(int i = 0; i < 10; ++i){
        [self.answers addObject:[NSString stringWithFormat:@"Симптом %d", i]];
    }
    [self.questionLabel setText:@"Выберите неисправность"];
    self.selectCounter = 0;
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
    if(self.selectCounter < 10){
        int num = indexPath.row;
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSString *str in self.answers){
            NSString *string = [str stringByAppendingString:[NSString stringWithFormat: @"-%d", num]];
            [array addObject:string];
        }
        self.answers = array;
        [tableView reloadData];
    } else{
        [tableView removeFromSuperview];
        self.questionLabel.frame = CGRectMake([UIApplication sharedApplication].keyWindow.bounds.size.width / 2 - self.questionLabel.frame.size.width / 2, [UIApplication sharedApplication].keyWindow.bounds.size.height / 2, self.questionLabel.frame.size.width, self.questionLabel.frame.size.height);
        NSString *str = [[self.answers objectAtIndex:indexPath.row] stringByAppendingString:[NSString stringWithFormat: @"-%d", indexPath.row]];
        NSString *resString = [str substringWithRange:NSMakeRange(8, str.length - 8)];
        [self.questionLabel setText:resString];
        self.navigationItem.title = @"Ответы";
    }
    
}

- (IBAction)nextButtonClicked:(UIButton *)sender {
    
}
@end
