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
    CGSize sizeThatFitsAuthor = [self.authorLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    CGFloat separatorY = (self.frame.size.height - 1.0f)/2.0f;
    self.separatorView.frame = CGRectMake(30.0f, separatorY, self.frame.size.width - 60.0f, 1.0f);
    self.titleLabel.frame = CGRectMake(0.0f, CGRectGetMinY(self.separatorView.frame) - 30.0f, self.frame.size.width, sizeThatFitsTitle.height);
    self.authorLabel.frame = CGRectMake(0.0f, CGRectGetMaxY(self.separatorView.frame) + 10.0f, self.frame.size.width, sizeThatFitsAuthor.height);
}

@end
