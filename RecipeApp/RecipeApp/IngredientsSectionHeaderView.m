//
//  IngredientsSectionHeaderView.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-25.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "IngredientsSectionHeaderView.h"
#import "RATextField.h"

@interface IngredientsSectionHeaderView () <UITextFieldDelegate>

@property (nonatomic) BOOL isFirstTimeEditing;

@end

@implementation IngredientsSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame sectionNumber:(NSInteger)sectionNumber
{
    if (self = [super initWithFrame:frame])
    {
        self.sectionNumer = sectionNumber;
        self.textField = [[RATextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textField.font = [UIFont boldSystemFontOfSize:14.0f];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.delegate = self;
        self.isFirstTimeEditing = YES;
        [self addSubview:self.textField];
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.isFirstTimeEditing)
    {
        self.textField.text = @"";
        self.isFirstTimeEditing = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.textField.text)
    {
        [self.delegate ingredientsSectionHeaderView:self didUpdateHeaderViewInSection:self.sectionNumer];
    }
}

@end
