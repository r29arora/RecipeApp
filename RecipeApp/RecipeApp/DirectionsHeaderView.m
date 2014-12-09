//
//  DirectionsHeaderView.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-12-09.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "DirectionsHeaderView.h"
#import "RATextField.h"

@interface DirectionsHeaderView () <UITextFieldDelegate>

@property (nonatomic) BOOL isFirstTimeEditing;

@end

@implementation DirectionsHeaderView

- (instancetype)initWithFrame:(CGRect)frame sectionNumber:(NSUInteger)sectionNumber
{
    if (self = [super initWithFrame:frame])
    {
        self.sectionNumber = sectionNumber;
        
        self.textField = [[RATextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
        self.textField.font = [UIFont fontWithName:@"Helvetiva-Bold" size:16.0f];
        self.textField.textAlignment = NSTextAlignmentNatural;
        self.textField.delegate = self;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        [self addSubview:self.textField];
        
        self.isFirstTimeEditing = YES;
    }
    return self;
}


#pragma mark - UITextFieldDelegate

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
    if ( [self.delegate respondsToSelector:@selector(directionsHeaderView:didUpdateHeaderViewInSection:)] && self.textField.text)
    {
        [self.delegate directionsHeaderView:self didUpdateHeaderViewInSection:self.sectionNumber];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.delegate respondsToSelector:@selector(directionsHeaderView:didUpdateHeaderViewInSection:)] && self.textField.text)
    {
        [self.delegate directionsHeaderView:self didUpdateHeaderViewInSection:self.sectionNumber];
    }
    return YES;
}

@end
