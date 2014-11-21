//
//  CreateIngredientsView.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "CreateIngredientsView.h"

@implementation CreateIngredientsView

- (instancetype)init
{
    if (self == [super init])
    {
        self.ingredientsLabel = [[UILabel alloc] init];
        self.ingredientsLabel.text = @"Ingredients";
        self.ingredientsLabel.textColor = [UIColor lightGrayColor];
        self.ingredientsLabel.font = [UIFont systemFontOfSize:20.0f];
        self.ingredientsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.ingredientsLabel];
        
        self.separatorView = [[UIView alloc] init];
        self.separatorView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.separatorView];
        
        self.ingredientsTextView = [[UITextView alloc] init];
        self.ingredientsTextView.text = @"Ingredients:";
        self.ingredientsTextView.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:self.ingredientsTextView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize sizeThatFitsLabel = [self.ingredientsLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    
    self.ingredientsLabel.frame = CGRectMake(5.0f, 5.0f, self.frame.size.width, sizeThatFitsLabel.height);
    self.separatorView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.ingredientsLabel.frame) + 5.0f, self.frame.size.width - 20.0f, 1.0f);
    self.ingredientsTextView.frame = CGRectMake(5.0f, CGRectGetMaxY(self.separatorView.frame), self.frame.size.width - 10.0f, self.frame.size.height - self.ingredientsLabel.frame.size.height - 20.0f);
}

@end
