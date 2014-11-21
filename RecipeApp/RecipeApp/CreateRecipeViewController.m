//
//  CreateRecipeViewController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "CreateRecipeViewController.h"

static const CGFloat kVerticalSpacing = 10.0f;

@interface CreateRecipeViewController ()

@end

@implementation CreateRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10.0f, 20.0f, self.view.frame.size.width - 20.0f, self.view.frame.size.height - 60.0f)];
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentScrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [self.contentScrollView addGestureRecognizer:tapGestureRecognizer];
    
    self.titleTextField = [[UITextField alloc] init];
    self.titleTextField.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    self.titleTextField.placeholder = @"Enter a Title";
    self.titleTextField.textAlignment = NSTextAlignmentCenter;
    [self.contentScrollView addSubview:self.titleTextField];
    
    self.ingredientsSeparatorLabel = [[UILabel alloc] init];
    self.ingredientsSeparatorLabel.text = @"Ingredients";
    self.ingredientsSeparatorLabel.textColor = [UIColor lightGrayColor];
    self.ingredientsSeparatorLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentScrollView addSubview:self.ingredientsSeparatorLabel];
    
    self.ingredientsSeparatorLine = [[UIView alloc] init];
    self.ingredientsSeparatorLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentScrollView addSubview:self.ingredientsSeparatorLine];
    
    self.ingredientsContainerView = [[UIView alloc] init];
    self.ingredientsContainerView.backgroundColor = [UIColor lightGrayColor];
    [self.contentScrollView addSubview:self.ingredientsContainerView];
}

- (void)viewWillLayoutSubviews
{
    self.titleTextField.frame = CGRectMake(0, 0, self.contentScrollView.frame.size.width, 50.0f);
    
    CGSize sizethatFits = [self.ingredientsSeparatorLabel sizeThatFits:CGSizeMake(self.contentScrollView.frame.size.width, CGFLOAT_MAX)];
    
    self.ingredientsSeparatorLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleTextField.frame) + kVerticalSpacing, self.contentScrollView.frame.size.width, sizethatFits.height);
    self.ingredientsSeparatorLine.frame = CGRectMake(0, CGRectGetMaxY(self.ingredientsSeparatorLabel.frame) + 5.0f, self.contentScrollView.frame.size.height, 1.0f);
    
    self.ingredientsContainerView.frame = CGRectMake(0.0f, CGRectGetMaxY(self.ingredientsSeparatorLine.frame) + kVerticalSpacing, self.contentScrollView.frame.size.width, 200.0f);
}

- (void)didTapView:(id)sender
{
    [self.view endEditing:YES];
}

@end
