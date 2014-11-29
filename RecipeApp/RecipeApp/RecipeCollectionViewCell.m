//
//  RecipeCollectionViewCell.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeCollectionViewCell.h"

@implementation RecipeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.separatorView = [[UIView alloc] init];
        self.separatorView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.separatorView];
        
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.authorLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        self.authorLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.authorLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize sizeThatFitsTitle = [self.titleLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    self.titleLabel.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, sizeThatFitsTitle.height);
    
    self.separatorView.frame = CGRectMake(30.0f, CGRectGetMaxY(self.titleLabel.frame) + 10.0f, self.frame.size.width - 60.0f, 1.0f);
    
    CGSize sizeThatFitsAuthor = [self.authorLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    self.authorLabel.frame = CGRectMake(0.0f, CGRectGetMaxY(self.separatorView.frame) + 10.0f, self.frame.size.width, sizeThatFitsAuthor.height);
}

@end
