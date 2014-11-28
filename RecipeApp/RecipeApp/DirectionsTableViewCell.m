//
//  DirectionsTableViewCell.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-28.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "DirectionsTableViewCell.h"

@interface DirectionsTableViewCell () <UITextViewDelegate>

@property (nonatomic) BOOL didEditOnce;

@end

@implementation DirectionsTableViewCell

- (void)setupDirectionTextView
{
    if (self.addDirectionButton)
    {
        [self.addDirectionButton removeFromSuperview];
        self.addSectionButton = nil;
    }
    if (self.addSectionButton)
    {
        [self.addSectionButton removeFromSuperview];
        self.addSectionButton = nil;
    }
    
    self.directionTextView = [[UITextView alloc] init];
    self.directionTextView.frame = self.bounds;
    self.directionTextView.text = @"Add Step here";
    self.directionTextView.delegate = self;
    self.directionTextView.bounces = NO;
    self.directionTextView.font = [UIFont systemFontOfSize:14.0f];
    self.directionTextView.scrollEnabled = NO;
    self.directionTextView.backgroundColor = [UIColor whiteColor];
    self.directionTextView.layer.borderWidth = 0.5f;
    self.directionTextView.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    [self addSubview:self.directionTextView];
}

- (void)setupAddDirectionButton
{
    if (self.addSectionButton)
    {
        [self.addSectionButton removeFromSuperview];
        self.addSectionButton = nil;
    }
    if (self.directionTextView)
    {
        [self.directionTextView removeFromSuperview];
        self.directionTextView = nil;
    }
    self.addDirectionButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.addDirectionButton setTitle:@" Add Direction" forState:UIControlStateNormal];
    [self.addDirectionButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.addDirectionButton.tintColor = [UIColor lightGrayColor];
    [self.addDirectionButton addTarget:self action:@selector(didTapAddDirectionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addDirectionButton];
}

- (void)setupAddSectionButton
{
    if (self.addDirectionButton)
    {
        [self.addDirectionButton removeFromSuperview];
        self.addDirectionButton = nil;
    }
    if (self.directionTextView)
    {
        [self.directionTextView removeFromSuperview];
        self.directionTextView = nil;
    }
    self.addSectionButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.addSectionButton setTitle:@" Add Step" forState:UIControlStateNormal];
    [self.addSectionButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.addSectionButton.tintColor = [UIColor lightGrayColor];
    [self.addSectionButton addTarget:self action:@selector(didTapAddSectionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addSectionButton];
}

- (void)layoutSubviews
{
    if (self.directionTextView)
    {
        self.directionTextView.frame = self.bounds;
    }
    if (self.addDirectionButton)
    {
        self.addDirectionButton.frame = self.bounds;
    }
    if (self.addSectionButton)
    {
        self.addSectionButton.frame = self.bounds;
    }
}

#pragma mark - Actions

- (void)didTapAddDirectionButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(directionsTableViewCell:didTapAddDirectionButtonAtIndexPath:)])
    {
        [self.delegate directionsTableViewCell:self didTapAddDirectionButtonAtIndexPath:self.indexPath];
    }
}

- (void)didTapAddSectionButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(directionsTableViewCell:didTapAddSectionButtonAtIndexPath:)])
    {
        [self.delegate directionsTableViewCell:self didTapAddSectionButtonAtIndexPath:self.indexPath];
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (!self.didEditOnce)
    {
        self.directionTextView.text = @"";
        self.didEditOnce = YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.didEditOnce && [self.delegate respondsToSelector:@selector(directionsTableViewCell:didFinishEditingAtIndexPath:)])
    {
        [self.delegate directionsTableViewCell:self didFinishEditingAtIndexPath:self.indexPath];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(directionsTableViewCell:didChangeTextViewAtIndexPath:)])
    {
        [self.delegate directionsTableViewCell:self didChangeTextViewAtIndexPath:self.indexPath];
    }
}

@end
