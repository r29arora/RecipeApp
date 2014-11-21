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

static const CGFloat kVerticalSpacing = 10.0f;
static const CGFloat kMinIngredientsSize = 100.0f;

@interface CreateRecipeViewController () <UITextViewDelegate>

@end

@implementation CreateRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10.0f, 20.0f, self.view.frame.size.width - 20.0f, self.view.frame.size.height - 60.0f)];
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    self.contentScrollView.scrollEnabled = YES;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.contentScrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [self.contentScrollView addGestureRecognizer:tapGestureRecognizer];
    
    self.titleTextField = [[UITextField alloc] init];
    self.titleTextField.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    self.titleTextField.placeholder = @"Title";
    self.titleTextField.textAlignment = NSTextAlignmentCenter;
    [self.contentScrollView addSubview:self.titleTextField];
    
    self.textFieldSeparatorView = [[UIView alloc] init];
    self.textFieldSeparatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentScrollView addSubview:self.textFieldSeparatorView];
    
    self.ingredientsSeparatorLabel = [[UILabel alloc] init];
    self.ingredientsSeparatorLabel.text = @"Ingredients";
    self.ingredientsSeparatorLabel.textColor = [UIColor lightGrayColor];
    self.ingredientsSeparatorLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentScrollView addSubview:self.ingredientsSeparatorLabel];
    
    self.ingredientsSeparatorLine = [[UIView alloc] init];
    self.ingredientsSeparatorLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentScrollView addSubview:self.ingredientsSeparatorLine];
    
    self.ingredientsContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kMinIngredientsSize)];
    self.ingredientsContainerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentScrollView addSubview:self.ingredientsContainerView];
    
    self.ingredientsTextView = [[UITextView alloc] init];
    self.ingredientsTextView.backgroundColor = [UIColor whiteColor];
    self.ingredientsTextView.delegate = self;
    self.ingredientsTextView.scrollEnabled = NO;
    [self.ingredientsContainerView addSubview:self.ingredientsTextView];

    self.checkMarkButton = [[UIView alloc] initWithFrame:CGRectZero];
    self.checkMarkButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.checkMarkButton];
    
    self.checkMarkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark"]];
    self.checkMarkImage.clipsToBounds = YES;
    self.checkMarkImage.backgroundColor = [UIColor clearColor];
    self.checkMarkImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.checkMarkButton addSubview:self.checkMarkImage];
    
    UITapGestureRecognizer *tapCheckMark = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCheckmark:)];
    [self.checkMarkButton addGestureRecognizer:tapCheckMark];
}

- (void)viewWillLayoutSubviews
{
    self.titleTextField.frame = CGRectMake(0, 0, self.contentScrollView.frame.size.width, 50.0f);
    
    self.textFieldSeparatorView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.titleTextField.frame), self.contentScrollView.frame.size.width - 20.0f, 1.0f);
    
    CGSize sizethatFits = [self.ingredientsSeparatorLabel sizeThatFits:CGSizeMake(self.contentScrollView.frame.size.width, CGFLOAT_MAX)];
    
    self.ingredientsSeparatorLabel.frame = CGRectMake(0, CGRectGetMaxY(self.textFieldSeparatorView.frame) + kVerticalSpacing, self.contentScrollView.frame.size.width, sizethatFits.height);
    
    self.ingredientsSeparatorLine.frame = CGRectMake(10.0f, CGRectGetMaxY(self.ingredientsSeparatorLabel.frame) + 5.0f, self.contentScrollView.frame.size.width - 20.0f, 1.0f);
    
    self.ingredientsContainerView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.ingredientsSeparatorLine.frame) + kVerticalSpacing, self.contentScrollView.frame.size.width - 20.0f, self.ingredientsContainerView.frame.size.height);
    
    self.ingredientsTextView.frame = CGRectMake(1.0f, 1.0f , self.ingredientsContainerView.frame.size.width - 2.0f, self.ingredientsContainerView.frame.size.height - 2.0f);
    
    self.checkMarkButton.frame = CGRectMake(CGRectGetMaxX(self.contentScrollView.frame) - 50.0f, CGRectGetMaxY(self.contentScrollView.frame) - 50.0f, self.checkMarkButton.frame.size.width, self.checkMarkButton.frame.size.height);
    
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.frame.size.width,self.contentScrollView.frame.size.height + 50.0f);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.checkMarkButton.layer.cornerRadius = 20.0f;
        self.checkMarkButton.frame = CGRectMake(self.checkMarkButton.frame.origin.x, self.checkMarkButton.frame.origin.y, 40.0f, 40.0f);
        self.checkMarkImage.frame = CGRectMake(self.checkMarkButton.bounds.origin.x + 2.0f, self.checkMarkButton.bounds.origin.y + 2.0f, self.checkMarkButton.bounds.size.width - 4.0f, self.checkMarkButton.bounds.size.height - 4.0f);
    } completion:^(BOOL finished) {
        [self viewWillLayoutSubviews];
    }];
}

- (void)didTapView:(id)sender
{
    [self.view endEditing:YES];
}

- (void)didTapCheckmark:(id)sender
{
    [self saveCurrentRecipe];
}

- (void)saveCurrentRecipe
{
    if ([self.titleTextField.text isEqualToString:@""] || [self.titleTextField.text isEqualToString:nil])
    {
        return;
    }
    
    RecipeObject *currentRecipe = [[RecipeObject alloc] init];
    currentRecipe.title = self.titleTextField.text;
    
    RecipeObjectManager *recipeManager = [[RecipeObjectManager alloc] init];
    
    [recipeManager loadDataFromDisk];
    [recipeManager.recipeObjects addObject:currentRecipe];
    [recipeManager saveDataToDisk];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize textViewSize = [self.ingredientsTextView sizeThatFits:CGSizeMake(self.ingredientsTextView.frame.size.width, CGFLOAT_MAX)];
    CGFloat textContainerHeight = (textViewSize.height >= kMinIngredientsSize) ? textViewSize.height : kMinIngredientsSize;
    self.ingredientsContainerView.frame = CGRectMake(self.ingredientsContainerView.frame.origin.x, self.ingredientsContainerView.frame.origin.y, self.ingredientsContainerView.frame.size.width, textContainerHeight);
    [self viewWillLayoutSubviews];
}

@end
