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
@property (nonatomic, strong) UIImageView *deleteImage;

@end

@implementation IngredientsSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame sectionNumber:(NSInteger)sectionNumber
{
    if (self = [super initWithFrame:frame])
    {
        self.sectionNumer = sectionNumber;
        
        self.textField = [[RATextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - frame.size.height, frame.size.height)];
        self.textField.font = [UIFont boldSystemFontOfSize:16.0f];
        self.textField.textAlignment = NSTextAlignmentNatural;
        self.textField.delegate = self;
        self.textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        self.isFirstTimeEditing = YES;
        [self addSubview:self.textField];
        
        self.deleteImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete"]];
        self.deleteImage.frame = CGRectMake(CGRectGetMaxX(self.textField.frame), 10.0f, frame.size.height - 20.0f, frame.size.height - 20.0f);
        self.deleteImage.clipsToBounds = YES;
        self.deleteImage.userInteractionEnabled = YES;
        [self addSubview:self.deleteImage];
        
        UITapGestureRecognizer *tapDeleteRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapDelete:)];
        [self.deleteImage addGestureRecognizer:tapDeleteRecognizer];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.textField.text)
    {
        [self.delegate ingredientsSectionHeaderView:self didUpdateHeaderViewInSection:self.sectionNumer];
    }
    return YES;
}

#pragma mark - TapGestureRecognizer

- (void)didTapDelete:(id)sender
{
    //Delete section
    if ([self.delegate respondsToSelector:@selector(ingredientsSectionHeaderView:didDeleteHeaderViewInSection:)])
    {
        [self.delegate ingredientsSectionHeaderView:self didDeleteHeaderViewInSection:self.sectionNumer];
    }
}

@end
