//
//  CreateRecipeViewController.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateRecipeViewController : UIViewController

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UIView *textFieldSeparatorView;

@property (nonatomic, strong) UILabel *ingredientsSeparatorLabel;
@property (nonatomic, strong) UIView *ingredientsSeparatorLine;
@property (nonatomic, strong) UIView *ingredientsContainerView;
@property (nonatomic, strong) UITextView *ingredientsTextView;

@property (nonatomic, strong) UIView *checkMarkButton;
@property (nonatomic, strong) UIImageView *checkMarkImage;

@end
