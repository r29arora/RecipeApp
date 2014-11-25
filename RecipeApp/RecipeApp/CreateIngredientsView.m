//
//  CreateIngredientsView.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "CreateIngredientsView.h"
#import "IngredientsTableViewCell.h"

@interface CreateIngredientsView () <UITableViewDelegate, UITableViewDataSource, IngredientsTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *ingredientSections;
@property (nonatomic, strong) NSMutableArray *sectionHeaders;

@end

@implementation CreateIngredientsView

- (instancetype)init
{
    if (self == [super init])
    {
        self.ingredientsLabel = [[UILabel alloc] init];
        self.ingredientsLabel.text = @"Ingredients";
        self.ingredientsLabel.textColor = [UIColor lightGrayColor];
        self.ingredientsLabel.font = [UIFont systemFontOfSize:20.0f];
        self.ingredientsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.ingredientsLabel];
        
        self.separatorView = [[UIView alloc] init];
        self.separatorView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.separatorView];
        
        self.ingredientsTableView = [[UITableView alloc] init];
        self.ingredientsTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.ingredientsTableView.showsHorizontalScrollIndicator = NO;
        self.ingredientsTableView.bounces = NO;
        self.ingredientsTableView.showsVerticalScrollIndicator = NO;
        self.ingredientsTableView.delegate = self;
        self.ingredientsTableView.dataSource = self;
        [self.ingredientsTableView registerClass:[IngredientsTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:self.ingredientsTableView];
        
        self.ingredientSections = [[NSMutableArray alloc] init];
        NSMutableArray *ingredients = [[NSMutableArray alloc] init];
        [ingredients addObject:@"one"];
        [ingredients addObject:@"two"];
        [self.ingredientSections addObject:ingredients];
        
        self.sectionHeaders = [[NSMutableArray alloc] init];
        [self.sectionHeaders addObject:@"Section 1"];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize sizeThatFitsLabel = [self.ingredientsLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    self.ingredientsLabel.frame = CGRectMake(5.0f, 5.0f, self.frame.size.width, sizeThatFitsLabel.height);
    self.separatorView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.ingredientsLabel.frame) + 5.0f, self.frame.size.width - 20.0f, 1.0f);
    self.ingredientsTableView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.separatorView.frame) + 10.0f, self.frame.size.width - 20.0f, self.frame.size.height - CGRectGetMaxY(self.separatorView.frame) - 20.0f);
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *ingredients = self.ingredientSections[indexPath.section];
    IngredientsTableViewCell *cell = (IngredientsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setupTextField];
    if (indexPath.row < ingredients.count)
    {
        if (ingredients[indexPath.row])
        {
            cell.textField.text = ingredients[indexPath.row];
        }
    }
    else if (indexPath.row == ingredients.count)
    {
        // Create a button rather than a textfield in the cell
        cell.textField.text = @"Add new";
    }
    cell.delegate = self;
    cell.index = indexPath.row;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *ingredients =  self.ingredientSections[section];
    return ingredients.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ingredientSections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaders[section];
}

#pragma mark - IngredientsTableViewCellDelegate

- (void)didTapAddTextFieldCell:(IngredientsTableViewCell *)cell atIndex:(NSInteger)index
{
    NSArray *indexPaths = @[[NSNumber numberWithLong:index]];
    [self.ingredientsTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
}

@end
