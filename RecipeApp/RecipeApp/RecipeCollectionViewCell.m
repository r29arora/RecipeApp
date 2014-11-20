//
//  RecipeCollectionViewCell.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeCollectionViewCell.h"

static const CGFloat kSpacing = 10.0f;

@implementation RecipeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.recipeImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.recipeImage.backgroundColor = [UIColor blueColor];
        [self addSubview:self.recipeImage];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.titleLabel];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.descriptionLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:self.descriptionLabel];
        
        self.recipeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.recipeButton setTitle:@"Go To Recipe" forState:UIControlStateNormal];
        self.recipeButton.backgroundColor = [UIColor greenColor];
        [self addSubview:self.recipeButton];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat imageWidth  = self.bounds.size.width*0.35f;
    CGFloat imageHeight = self.bounds.size.height - 60.0f;
    CGFloat imageX = kSpacing;
    CGFloat imageY = kSpacing;
    
    self.recipeImage.frame = CGRectMake(imageX, imageY, imageWidth - kSpacing, imageHeight - kSpacing);
    
    CGFloat titleWidth  = (self.bounds.size.width - self.recipeImage.frame.size.width);
    CGFloat titleHeight = imageHeight/2.0f;
    CGFloat titleX = imageWidth + kSpacing;
    CGFloat titleY = kSpacing;
    
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleWidth - kSpacing*3.0f, titleHeight - kSpacing);
    
    CGFloat descriptionWidth = titleWidth;
    CGFloat descriptionHeight = imageHeight/2.0f;
    CGFloat descriptionX = titleX;
    CGFloat descriptionY = titleHeight + kSpacing;
    
    self.descriptionLabel.frame = CGRectMake(descriptionX, descriptionY, descriptionWidth - 3.0f*kSpacing, descriptionHeight - kSpacing);
    
    CGFloat buttonWidth = self.bounds.size.width;
    CGFloat buttonHeight = self.bounds.size.height -  imageHeight;
    CGFloat buttonX = kSpacing;
    CGFloat buttonY = imageHeight + kSpacing;
    
    self.recipeButton.frame = CGRectMake(buttonX, buttonY, buttonWidth - 2.0f*kSpacing, buttonHeight - kSpacing*2.0f);
}

@end
