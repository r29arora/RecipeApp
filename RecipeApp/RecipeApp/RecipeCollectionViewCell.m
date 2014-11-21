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
        self.recipeImage.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:255.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        self.recipeImage.contentMode = UIViewContentModeScaleAspectFill;
        self.recipeImage.clipsToBounds = YES;
        self.recipeImage.image = [UIImage imageNamed:@"background"];
        [self addSubview:self.recipeImage];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        [self addSubview:self.titleLabel];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.descriptionLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        [self addSubview:self.descriptionLabel];
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
}

@end
