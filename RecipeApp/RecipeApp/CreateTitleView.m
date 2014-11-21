//
//  CreateTitleView.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "CreateTitleView.h"

@implementation CreateTitleView

- (instancetype)init
{
    if (self = [super init])
    {
        self.titleLabel = [[UITextView alloc] init];
        self.titleLabel.text = @"Enter a Title";
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        self.titleLabel.scrollEnabled = NO;
        self.titleLabel.delegate = self;
        [self addSubview:self.titleLabel];
        
        self.separatorView = [[UIView alloc] init];
        self.separatorView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.separatorView];
        
        self.authorLabel = [[UITextView alloc] init];
        self.authorLabel.text = @"By: Rajul Arora";
        self.authorLabel.textColor = [UIColor darkGrayColor];
        self.authorLabel.font = [UIFont italicSystemFontOfSize:14.0f];
        self.authorLabel.scrollEnabled = NO;
        self.authorLabel.delegate = self;
        [self addSubview:self.authorLabel];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
        [self addGestureRecognizer:tapGestureRecognizer];
}
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self resizeViews];
}

- (void)resizeViews
{
    CGSize sizeThatFitsTitleLabel = [self.titleLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    CGFloat titleLabelX = (self.frame.size.width - sizeThatFitsTitleLabel.width)/2.0f;
    CGFloat titleLabelY = (self.frame.size.height - sizeThatFitsTitleLabel.height)/2.0f - 40.0f;
    
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, sizeThatFitsTitleLabel.width, sizeThatFitsTitleLabel.height);
    
    self.separatorView.frame = CGRectMake(30.0f, CGRectGetMaxY(self.titleLabel.frame) + 10.0f, self.frame.size.width - 60.0f, 1.0f);
    
    CGSize sizeThatFitsAuthorLabel = [self.authorLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    CGFloat authorLabelX = (self.frame.size.width - sizeThatFitsAuthorLabel.width)/2.0f;
    
    self.authorLabel.frame = CGRectMake(authorLabelX, CGRectGetMaxY(self.separatorView.frame) + 10.0f, sizeThatFitsAuthorLabel.width, sizeThatFitsAuthorLabel.height);
}

#pragma mark - Actions

- (void)didTapView:(id)selector
{
    [self endEditing:YES];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self resizeViews];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.authorLabel && !self.didChangeAuthorLabelForTheFirstTime)
    {
        textView.text = @"By:";
        self.didChangeAuthorLabelForTheFirstTime = YES;
    }
    else if (textView == self.titleLabel && !self.didChangeTitleLabelForTheFirstTime)
    {
        textView.text = @"";
        self.didChangeTitleLabelForTheFirstTime = YES;
    }
    [self resizeViews];
}

@end
