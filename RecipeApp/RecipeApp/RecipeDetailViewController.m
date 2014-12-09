//
//  RecipeDetailViewController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-12-08.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RecipeObject.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:170.0f/255.0f blue:220.0f/255.0f alpha:0.8f];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.contentScrollView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2f];
    [self.view addSubview:self.contentScrollView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = self.recipeObject.title;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.contentScrollView addSubview:self.titleLabel];
    
    self.separatorView = [[UIView alloc] init];
    self.separatorView.backgroundColor = [UIColor whiteColor];
    [self.contentScrollView addSubview:self.separatorView];
    
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.textAlignment = NSTextAlignmentCenter;
    self.authorLabel.text = self.recipeObject.author;
    self.authorLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
    self.authorLabel.textColor = [UIColor whiteColor];
    [self.contentScrollView addSubview:self.authorLabel];
    
    self.ingredientsTitleLabel = [[UILabel alloc] init];
    self.ingredientsTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.ingredientsTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    self.ingredientsTitleLabel.textColor = [UIColor whiteColor];
    self.ingredientsTitleLabel.text = @"Ingredients";
    [self.contentScrollView addSubview:self.ingredientsTitleLabel];
    
    self.ingredientsLabel = [[UILabel alloc] init];
    self.ingredientsLabel.textAlignment = NSTextAlignmentLeft;
    self.ingredientsLabel.textColor = [UIColor whiteColor];
    self.ingredientsLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    self.ingredientsLabel.text = [self parseIngredientsIntoString];
    self.ingredientsLabel.numberOfLines = 0;
    [self.contentScrollView addSubview:self.ingredientsLabel];
    
    self.directionsTitleLabel = [[UILabel alloc] init];
    self.directionsTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.directionsTitleLabel.font = [UIFont fontWithName:@"Helvetiva-Bold" size:16.0f];
    self.directionsTitleLabel.textColor = [UIColor whiteColor];
    self.directionsTitleLabel.text = @"Directions";
    [self.contentScrollView addSubview:self.directionsTitleLabel];
    
    self.directionsLabel = [[UILabel alloc] init];
    self.directionsLabel.textAlignment = NSTextAlignmentLeft;
    self.directionsLabel.textColor = [UIColor whiteColor];
    self.directionsLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    self.directionsLabel.numberOfLines = 0;
    self.directionsLabel.text = [self parseDirectionsIntoString];
    [self.contentScrollView addSubview:self.directionsLabel];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Title Label
    CGSize sizeThatFitsTitleLabel = [self.titleLabel sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    
    self.titleLabel.frame = CGRectMake(0.0f, 20.0f, self.contentScrollView.frame.size.width, sizeThatFitsTitleLabel.height);
    
    // Separator View
    self.separatorView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.titleLabel.frame) + 5.0f, self.contentScrollView.frame.size.width - 20.0f, 0.5f);

    // Author Label
    CGSize sizeThatFitsAuthorLabel = [self.authorLabel sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    self.authorLabel.frame = CGRectMake(0.0f, CGRectGetMaxY(self.separatorView.frame) + 10.0f, self.contentScrollView.frame.size.width, sizeThatFitsAuthorLabel.height);
    
    // Ingredients Title Label
    CGSize sizeThatFitsIngredientsTitleLabel = [self.ingredientsTitleLabel sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    self.ingredientsTitleLabel.frame = CGRectMake(10.0f, CGRectGetMaxY(self.authorLabel.frame) + 10.0f, sizeThatFitsIngredientsTitleLabel.width, sizeThatFitsIngredientsTitleLabel.height);
    
    CGSize sizeThatFitsIngredients = [self.ingredientsLabel sizeThatFits:CGSizeMake(self.view.frame.size.width - 20.0f, CGFLOAT_MAX)];
    self.ingredientsLabel.frame = CGRectMake(10.0f, CGRectGetMaxY(self.ingredientsTitleLabel.frame) + 5.0f, self.view.frame.size.width - 20.0f, sizeThatFitsIngredients.height);
    
    CGSize sizeThatFitsDirectionTitleLabel = [self.directionsTitleLabel sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    self.directionsTitleLabel.frame = CGRectMake(10.0f, CGRectGetMaxY(self.ingredientsLabel.frame), self.view.frame.size.width - 20.0f, sizeThatFitsDirectionTitleLabel.height);
    
    CGSize sizeThatFitsDirectionsLabel = [self.directionsLabel sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    
    self.directionsLabel.frame = CGRectMake(10.0f, CGRectGetMaxY(self.directionsTitleLabel.frame), self.view.frame.size.width- 20.0f, sizeThatFitsDirectionsLabel.height);
    
    // Scroll View Content Size (always at the bottom)
    self.contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.directionsLabel.frame));
}

- (NSString *)parseIngredientsIntoString
{
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    for (NSUInteger x = 0; x < self.recipeObject.ingredients.count; x++)
    {
        NSString *sectionTitle = self.recipeObject.ingredientSections[x];
        [mutableString insertString:[sectionTitle stringByAppendingString:@"\n\n"] atIndex:[mutableString length]];
        
        NSMutableArray *currentSection = self.recipeObject.ingredients[x];
        for (NSUInteger y = 0; y < currentSection.count; y++)
        {
            NSString *currentIngredient = currentSection[y];
            [mutableString insertString:[currentIngredient stringByAppendingString:@"\n"] atIndex:[mutableString length]];
        }
    }
    
    return [mutableString copy];
}

- (NSString *)parseDirectionsIntoString
{
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    for (NSUInteger x = 0; x < self.recipeObject.directions.count; x++)
    {
        NSString *sectionTitle = self.recipeObject.directionSections[x];
        [mutableString insertString:[sectionTitle stringByAppendingString:@"\n\n"] atIndex:[mutableString length]];
        NSMutableArray *currentSection = self.recipeObject.directions[x];
        for (NSUInteger y =0; y < currentSection.count; y++)
        {
            NSString *currentDirection = currentSection[y];
            [mutableString insertString:[currentDirection stringByAppendingString:@"\n"] atIndex:[mutableString length]];
        }
    }
    return [mutableString copy];
}

@end
