//
//  MenuViewController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "MenuViewController.h"

typedef enum {
    MenuTableViewTypeOne = 0,
    MenuTableViewTypeTwo,
    MenuTableViewTypeThree,
    MenuTableViewTypeFour,
    MenuTableViewTypeFive
}MenuTableViewType;

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.listView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.bounces = NO;
    [self.view addSubview:self.listView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.tintColor = [UIColor whiteColor];
        switch (indexPath.row) {
            case MenuTableViewTypeOne:
                cell.textLabel.text = @"one";
                break;
            case MenuTableViewTypeTwo:
                cell.textLabel.text = @"two";
                break;
            case MenuTableViewTypeThree:
                cell.textLabel.text = @"three";
                break;
            case MenuTableViewTypeFour:
                cell.textLabel.text = @"four";
                break;
            case MenuTableViewTypeFive:
                cell.textLabel.text = @"five";
                break;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate menuViewController:self didSelectItemAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height/5.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

@end
