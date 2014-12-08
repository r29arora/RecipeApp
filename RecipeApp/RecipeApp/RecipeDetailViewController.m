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
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGSize sizeThatFitsTitleLabel = [self.titleLabel sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    
    self.titleLabel.frame = CGRectMake(0.0f, 20.0f, self.contentScrollView.frame.size.width, sizeThatFitsTitleLabel.height);
    self.separatorView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.titleLabel.frame) + 5.0f, self.contentScrollView.frame.size.width - 20.0f, 0.5f);

    CGSize sizeThatFitsAuthorLabel = [self.authorLabel sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    self.authorLabel.frame = CGRectMake(0.0f, CGRectGetMaxY(self.separatorView.frame) + 10.0f, self.contentScrollView.frame.size.width, sizeThatFitsAuthorLabel.height);
    self.contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.authorLabel.frame));
}

@end
