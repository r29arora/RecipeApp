//
//  CreateRecipeViewController.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *CreateViewControllerDidFinishEditingNotification = @"CreateViewControllerDidFinishEditingNotification";

@class CreateTitleView;
@class CreateIngredientsView;
@class CreateDirectionsView;
@class RecipeObject;

@protocol CreateRecipeViewControllerDelegate <NSObject>

- (void)createRecipeViewControllerDidFinishEditing;

@end

@interface CreateRecipeViewController : UIViewController

@property (nonatomic, strong) id<CreateRecipeViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *contentContainerView;

@property (nonatomic, strong) UIView *titleContainerView;
@property (nonatomic, strong) CreateTitleView *titleView;

@property (nonatomic, strong) UIView *ingredientsContainerView;
@property (nonatomic, strong) CreateIngredientsView *ingredientsView;

@property (nonatomic, strong) UIView *directionsContainerView;
@property (nonatomic, strong) CreateDirectionsView *directionsView;

@property (nonatomic, strong) RecipeObject *currentRecipe;

@end
