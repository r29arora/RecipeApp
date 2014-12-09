//
//  RecipeDetailViewController.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-12-08.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecipeObject;

@interface RecipeDetailViewController : UIViewController

@property (nonatomic, strong) RecipeObject *recipeObject;

@property (nonatomic, strong) UIScrollView *contentScrollView;

// Title
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UILabel *authorLabel;

// Ingredients
@property (nonatomic, strong) UILabel *ingredientsTitleLabel;
@property (nonatomic, strong) UILabel *ingredientsLabel;

// Directions
@property (nonatomic, strong) UILabel *directionsTitleLabel;
@property (nonatomic, strong) UILabel *directionsLabel;

@end
