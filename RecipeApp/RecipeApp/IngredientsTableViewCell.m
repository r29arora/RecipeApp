//
//  IngredientsTableViewCell.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-25.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "IngredientsTableViewCell.h"

@interface IngredientsTableViewCell () <UITextFieldDelegate>

@property (nonatomic) BOOL didEditOnce;

@end

@implementation IngredientsTableViewCell

- (void)setupTextField
{
    if (self.addTextFieldButton)
    {
        [self.addTextFieldButton removeFromSuperview];
    }
    self.textField = [[RATextField alloc] init];
    self.textField.delegate = self;
    self.didEditOnce = NO;
    [self addSubview:self.textField];
}

- (void)setupAddTextFieldButton
{
    self.addTextFieldButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.addTextFieldButton setTitle:@" Add Ingredient" forState:UIControlStateNormal];
    [self.addTextFieldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addTextFieldButton setTintColor:[UIColor blackColor]];
    [self.addTextFieldButton addTarget:self action:@selector(didTapAddTextField:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addTextFieldButton];
}

- (void)replaceTextFieldWithAddSectionButton
{
    if (self.textField)
    {
        [self.textField removeFromSuperview];
        self.textField = nil;
    }
    [self setupAddTextFieldButton];
}

- (void)layoutSubviews
{
    if (self.textField)
    {
        self.textField.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    if (self.addTextFieldButton)
    {
        self.addTextFieldButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
}

- (void)didTapAddTextField:(id)sender
{
    [self.delegate ingredientsTableViewCell:self didTapAddTextFieldButtonAtIndexPath:self.indexPath];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!self.didEditOnce)
    {
        self.didEditOnce = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEditOnce)
    {
        [self.delegate ingredientsTableViewCell:self didFinishEditingAtIndexPath:self.indexPath];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.didEditOnce)
    {
        [self.delegate ingredientsTableViewCell:self didChangeCharactersAtIndexPath:self.indexPath];
    }
    return YES;
}

@end
