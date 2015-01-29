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
#import "CreateTitleView.h"
#import "CreateIngredientsView.h"
#import "UIView+Shadow.h"
#import "CreateDirectionsView.h"

#import <MBProgressHUD.h>

@interface CreateRecipeViewController () <CreateDirectionsViewDelegate>

@end

@implementation CreateRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentContainerView = [[UIScrollView alloc] init];
    self.contentContainerView.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:170.0f/255.0f blue:220.0f/255.0f alpha:0.8f];
    self.contentContainerView.pagingEnabled = YES;
    [self.view addSubview:self.contentContainerView];
    
    self.titleContainerView = [[UIView alloc] init];
    self.titleContainerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentContainerView addSubview:self.titleContainerView];
    
    self.titleView = [[CreateTitleView alloc] init];
    self.titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.titleContainerView addSubview:self.titleView];
    
    self.ingredientsContainerView = [[UIView alloc] init];
    self.ingredientsContainerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentContainerView addSubview:self.ingredientsContainerView];
    
    self.ingredientsView = [[CreateIngredientsView alloc] init];
    self.ingredientsView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.ingredientsContainerView addSubview:self.ingredientsView];
    
    self.directionsContainerView = [[UIView alloc] init];
    self.directionsContainerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [self.contentContainerView addSubview:self.directionsContainerView];
    
    self.directionsView = [[CreateDirectionsView alloc] init];
    self.directionsView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.directionsView.delegate = self;
    [self.directionsContainerView addSubview:self.directionsView];
    
    self.currentRecipe = [[RecipeObject alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

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
    [[NSNotificationCenter defaultCenter] removeObserver:self.ingredientsView];
}

#pragma mark - CreateDirectionsViewDelegate

- (void)didFinishWritingRecipe
{
    if ([self checkInputs])
    {
        [self saveCurrentRecipe];
    }
}

#pragma mark - Saving Current Recipe Object

- (BOOL)checkInputs
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BOOL valid = YES;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    hud.labelColor = [UIColor groupTableViewBackgroundColor];
    hud.mode = MBProgressHUDModeText;

    // Title of Recipe
    if ([self.titleView.titleLabel.text isEqualToString:@""] ||
        [self.titleView.titleLabel.text isEqualToString:@"Enter a Title"])
    {
        hud.labelText = @"Enter a Title";
        valid = NO;
    }
    // Author of Recipe
    else if ([self.titleView.authorLabel.text isEqualToString:@""] ||
        [self.titleView.authorLabel.text isEqualToString:@"By:"])
    {
        hud.labelText = @"Enter an author name";
        valid = NO;
    }
    else if (!self.ingredientsView.ingredientSections ||
             !self.ingredientsView.sectionHeaders)
    {
        hud.labelText = @"Enter Ingredients";
        valid = NO;
    }
    else if (!self.directionsView.directionSections ||
             !self.directionsView.directionSectionHeaders)
    {
        hud.labelText = @"Enter Directions";
        valid = NO;
    }
    
    [hud hide:YES afterDelay:1.0];
    return valid;
}

- (void)saveCurrentRecipe
{
<<<<<<< HEAD
//    RecipeObjectManager *recipeManager = [[RecipeObjectManager alloc] init];
    
//    [recipeManager loadDataFromDisk];
    
    [self.currentRecipe loadDataFromDisk];
=======
>>>>>>> 5acafb16478f22b9eb215a4e2021e236a165da1d
    
    self.currentRecipe.title = self.titleView.titleLabel.text;
    self.currentRecipe.author = self.titleView.authorLabel.text;
<<<<<<< HEAD
//    self.currentRecipe.ingredients = self.ingredientsView.ingredientSections;
//    self.currentRecipe.directions = self.directionsView.directionSections;
    
    [self.currentRecipe saveDataToDisk];
    
    // Send Message to Delegate
    [self.delegate createRecipeViewControllerDidFinishEditing];
=======
    self.currentRecipe.ingredients = self.ingredientsView.ingredientSections;
    self.currentRecipe.ingredientSections = self.ingredientsView.sectionHeaders;
    self.currentRecipe.directions = self.directionsView.directionSections;
    self.currentRecipe.directionSections = self.directionsView.directionSectionHeaders;
    
    [self.currentRecipe saveDataToDiskWithCompletion:^{
        if ([self.delegate respondsToSelector:@selector(createRecipeViewControllerDidFinishEditing)])
        {
            [self.delegate createRecipeViewControllerDidFinishEditing];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CreateViewControllerDidFinishEditingNotification object:nil];
        
    }];
>>>>>>> 5acafb16478f22b9eb215a4e2021e236a165da1d
}

@end
