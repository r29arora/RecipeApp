//
//  CreateRecipeViewController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "CreateRecipeViewController.h"
#import "BottomMenuController.h"
#import "RecipeObject.h"
#import "RecipeObjectManager.h"
#import "CreateTitleView.h"
#import "CreateIngredientsView.h"
#import "UIView+Shadow.h"

@interface CreateRecipeViewController ()

@end

@implementation CreateRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentContainerView = [[UIScrollView alloc] init];
    self.contentContainerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.contentContainerView.pagingEnabled = YES;
    [self.view addSubview:self.contentContainerView];
    
    self.titleContainerView = [[UIView alloc] init];
    self.titleContainerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentContainerView addSubview:self.titleContainerView];
    
    self.titleView = [[CreateTitleView alloc] init];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.titleContainerView addSubview:self.titleView];
    
    self.ingredientsContainerView = [[UIView alloc] init];
    self.ingredientsContainerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentContainerView addSubview:self.ingredientsContainerView];
    
    self.ingredientsView = [[CreateIngredientsView alloc] init];
    self.ingredientsView.backgroundColor = [UIColor whiteColor];
    [self.ingredientsContainerView addSubview:self.ingredientsView];
    
    self.directionsContainerView = [[UIView alloc] init];
    self.directionsContainerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentContainerView addSubview:self.directionsContainerView];
    
    self.directionsView = [[UIView alloc] init];
    self.directionsView.backgroundColor = [UIColor whiteColor];
    [self.directionsContainerView addSubview:self.directionsView];
    
    self.currentRecipe = [[RecipeObject alloc] init];
}

- (void)viewWillLayoutSubviews
{
    self.contentContainerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.titleContainerView.frame = self.contentContainerView.frame;
    self.titleView.frame = CGRectMake(30.0f, 30.0f, self.titleContainerView.frame.size.width - 60.0f, self.titleContainerView.frame.size.height - 100.0f);
    [self.titleView createShadow];
    
    self.ingredientsContainerView.frame = CGRectMake(CGRectGetMaxX(self.contentContainerView.frame), 0, self.contentContainerView.frame.size.width, self.contentContainerView.frame.size.height);
    self.ingredientsView.frame = CGRectMake(30.0f, 30.0f, self.contentContainerView.frame.size.width - 60.0f, self.contentContainerView.frame.size.height - 100.0f);
    [self.ingredientsView createShadow];
    
    self.directionsContainerView.frame = CGRectMake(CGRectGetMaxX(self.ingredientsContainerView.frame), 0, self.contentContainerView.frame.size.width, self.contentContainerView.frame.size.height);
    self.directionsView.frame = CGRectMake(30.0f, 30.0f, self.contentContainerView.frame.size.width - 60.0f, self.contentContainerView.frame.size.height - 100.0f);
    [self.directionsView createShadow];
    
    self.contentContainerView.contentSize = CGSizeMake(CGRectGetMaxX(self.directionsContainerView.frame), self.contentContainerView.frame.size.height);
}

- (void)dealloc
{
    self.currentRecipe = nil;
}

#pragma mark - Saving Recipe Object

- (void)saveCurrentRecipe
{
    RecipeObjectManager *recipeManager = [[RecipeObjectManager alloc] init];
    
    [recipeManager loadDataFromDisk];
    
    // Set Data Here
    [recipeManager.recipeObjects addObject:self.currentRecipe];
    
    [recipeManager saveDataToDisk];
    
    // Send Message to Delegate
    [self.delegate createRecipeViewControllerDidFinishEditing];
}
@end
