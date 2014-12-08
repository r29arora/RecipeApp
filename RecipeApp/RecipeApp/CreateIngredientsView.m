//
//  CreateIngredientsView.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "CreateIngredientsView.h"
#import "IngredientsTableViewCell.h"
#import "IngredientsSectionHeaderView.h"

@interface CreateIngredientsView () <UITableViewDelegate, UITableViewDataSource, IngredientsTableViewCellDelegate, IngredientsSectionHeaderViewDelegate>

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
        self.ingredientsTableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        self.ingredientsTableView.showsHorizontalScrollIndicator = NO;
        self.ingredientsTableView.showsVerticalScrollIndicator = NO;
        self.ingredientsTableView.delegate = self;
        self.ingredientsTableView.dataSource = self;
        self.ingredientsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.ingredientsTableView registerClass:[IngredientsTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:self.ingredientsTableView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
        [self.ingredientsTableView addGestureRecognizer:tapGesture];
        
        UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
        [self addGestureRecognizer:viewTapGesture];
        
        self.ingredientSections = [[NSMutableArray alloc] init];
        NSMutableArray *ingredients = [[NSMutableArray alloc] init];
        [self.ingredientSections addObject:ingredients];
        
        self.sectionHeaders = [[NSMutableArray alloc] init];
        [self.sectionHeaders addObject:@"Section 1"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
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

- (void)didTapView:(id)sender
{
    [self endEditing:YES];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    NSMutableArray *ingredients = self.ingredientSections[indexPath.section];
    IngredientsTableViewCell *cell = (IngredientsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell)
    {
        cell = [[IngredientsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    if (!cell.textField)
    {
        //initialize textfield if it hasn't already been initialized
        [cell setupTextField];
    }
    
    // Normal ingredients cell
    if (indexPath.row < ingredients.count)
    {
        if (ingredients[indexPath.row])
        {
            //Set the textfield text from the array of ingredients at the current section
            cell.textField.text = ingredients[indexPath.row];
        }
    }
    // Add Ingredients Button
    if (indexPath.row == ingredients.count)
    {
        // Create a button rather than a textfield in the cell
        if (!cell.addTextFieldButton)
        {
            [cell replaceTextFieldWithAddRowButton];
        }
    }
    // Add Section Button
    if (indexPath.row == ingredients.count + 1)
    {
        // Create a button rather than a textfieldin the cell
        if (!cell.addTextFieldButton)
        {
            [cell replaceTextFieldWithAddSectionButton];
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *ingredients =  self.ingredientSections[section];
    return ingredients.count + 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ingredientSections.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = self.sectionHeaders[section];
    IngredientsSectionHeaderView *sectionHeaderView = [[IngredientsSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40.0f) sectionNumber:section];
    sectionHeaderView.textField.text = sectionTitle;
    sectionHeaderView.delegate = self;
    sectionHeaderView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

#pragma mark - NSNotificationCenter Notification Handling

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat keyboardHeight = keyboardSize.height;
    
    if (self.ingredientsTableView.contentSize.height > self.frame.size.height)
    {
        self.ingredientsTableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, keyboardHeight, 0.0f);
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.ingredientsTableView.contentInset = UIEdgeInsetsZero;
}

#pragma mark - IngredientsTableViewCellDelegate

- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didTapAddTextFieldButtonAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *ingredients = self.ingredientSections[indexPath.section];
    [ingredients addObject:@"Enter a New Ingredient"];
    [self.ingredientsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:ingredients.count - 1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.ingredientsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:ingredients.count + 1 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didTapAddSectionButtonAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *newIngredientsArray = [[NSMutableArray alloc] init];
    [self.ingredientSections insertObject:newIngredientsArray atIndex:indexPath.section+1];
    [self.sectionHeaders insertObject:@"Enter a Section Title" atIndex:indexPath.section+1];
    [self.ingredientsTableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section+1] withRowAnimation:UITableViewRowAnimationBottom];
    [self.ingredientsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newIngredientsArray.count+1 inSection:indexPath.section + 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didFinishEditingAtIndexPath:(NSIndexPath *)indexPath
{
    // Update ingredients array with appropriate content
    NSMutableArray *ingredients = self.ingredientSections[indexPath.section];
    ingredients[indexPath.row]  = cell.textField.text;
}

- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didChangeCharactersAtIndexPath:(NSIndexPath *)indexPath
{
    // Update ingredients array with appropriate content
    NSMutableArray *ingredients = self.ingredientSections[indexPath.section];
    ingredients[indexPath.row] = cell.textField.text;
}

- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didTapReturnAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *ingredients = self.ingredientSections[indexPath.section];
    //Add a new cell if you are the last textfield
    if (indexPath.row == ingredients.count - 1)
    {
        [self ingredientsTableViewCell:cell didTapAddTextFieldButtonAtIndexPath:indexPath];
    }
}

#pragma mark - IngredientsSectionHeaderViewDelegate

- (void)ingredientsSectionHeaderView:(IngredientsSectionHeaderView *)headerView didUpdateHeaderViewInSection:(NSInteger)section
{
    // Update Section Headers array with appropriate content
    self.sectionHeaders[section] = headerView.textField.text;
}

@end
