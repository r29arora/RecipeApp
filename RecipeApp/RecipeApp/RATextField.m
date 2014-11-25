//
//  RATextField.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-25.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RATextField.h"

@implementation RATextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 15.0f;
    textRect.size.width -= 20.0f;
    return textRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

@end
