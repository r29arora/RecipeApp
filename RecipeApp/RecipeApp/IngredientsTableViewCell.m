//
//  IngredientsTableViewCell.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-25.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "IngredientsTableViewCell.h"

@implementation IngredientsTableViewCell

- (void)setupTextField
{
    self.textField = [[RATextField alloc] init];
    self.textField.placeholder = @"Enter an ingredient";
    [self addSubview:self.textField];
}

- (void)didTapButton:(id)sender
{
    [self.delegate didTapAddTextFieldCell:self atIndex:self.index];
}

- (void)layoutSubviews
{
    self.textField.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
