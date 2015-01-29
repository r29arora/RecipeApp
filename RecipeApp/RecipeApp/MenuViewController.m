//
//  MenuViewController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.listView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.listView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.bounces = NO;
    [self.view addSubview:self.listView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case MenuTableViewTypeNewRecipe:
                cell.titleLabel.text = @"New Recipe";
                cell.sideImage.image = [UIImage imageNamed:@"add"];
                break;
            case MenuTableViewTypeMyRecipes:
                cell.titleLabel.text = @"My Recipes";
                cell.sideImage.image = [UIImage imageNamed:@"my_recipes"];
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
    return self.view.frame.size.height/2.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

@end
