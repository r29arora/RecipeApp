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
        self.addTextFieldButton = nil;
    }
    if (self.addSectionButton)
    {
        [self.addSectionButton removeFromSuperview];
        self.addSectionButton = nil;
    }
    self.textField = [[RATextField alloc] init];
    self.textField.delegate = self;
    self.textField.font = [UIFont systemFontOfSize:14.0f];
    self.didEditOnce = NO;
    [self addSubview:self.textField];
}

- (void)setupAddTextFieldButton
{
    self.addTextFieldButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.addTextFieldButton setTitle:@" Add Ingredient" forState:UIControlStateNormal];
    [self.addTextFieldButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.addTextFieldButton setTintColor:[UIColor grayColor]];
    [self.addTextFieldButton addTarget:self action:@selector(didTapAddTextField:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addTextFieldButton];
}

- (void)setupAddSectionButton
{
    self.addSectionButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.addSectionButton setTitle:@" Add Section" forState:UIControlStateNormal];
    [self.addSectionButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.addSectionButton setTintColor:[UIColor grayColor]];
    [self.addSectionButton addTarget:self action:@selector(didTapAddSection:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addSectionButton];
}

- (void)replaceTextFieldWithAddRowButton
{
    if (self.textField)
    {
        [self.textField removeFromSuperview];
        self.textField = nil;
    }
    if (self.addSectionButton)
    {
        [self.addSectionButton removeFromSuperview];
        self.addSectionButton = nil;
    }
    [self setupAddTextFieldButton];
}

- (void)replaceTextFieldWithAddSectionButton
{
    if (self.textField)
    {
        [self.textField removeFromSuperview];
        self.textField = nil;
    }
    if (self.addTextFieldButton)
    {
        [self.addTextFieldButton removeFromSuperview];
        self.addTextFieldButton = nil;
    }
    [self setupAddSectionButton];
    
}

- (void)layoutSubviews
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    if (self.textField)
    {
        self.textField.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    if (self.addTextFieldButton)
    {
        self.addTextFieldButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    if (self.addSectionButton)
    {
        self.addSectionButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
}

- (void)didTapAddTextField:(id)sender
{
    [self.delegate ingredientsTableViewCell:self didTapAddTextFieldButtonAtIndexPath:self.indexPath];
}

- (void)didTapAddSection:(id)sender
{
    [self.delegate ingredientsTableViewCell:self didTapAddSectionButtonAtIndexPath:self.indexPath];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!self.didEditOnce)
    {
        self.textField.text = @"";
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.delegate ingredientsTableViewCell:self didTapReturnAtIndexPath:self.indexPath];
    return YES;
}

@end
