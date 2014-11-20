//
//  MenuBarView.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "MenuBarView.h"

@interface MenuBarView ()

@end

@implementation MenuBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //Setup Container View
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.containerView];
        
        //Setup Visible Menu Bar View
        self.menuBar = [[UIView alloc] initWithFrame:CGRectMake(0, 18.0f, self.containerView.frame.size.width, self.containerView.frame.size.height-18.0f)];
        self.menuBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.containerView addSubview:self.menuBar];
        
        //Setup Menu button
        self.centerButton = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0f, 40.0f)];
        self.centerButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.containerView addSubview:self.centerButton];
        
        //Setup Arrow Icon
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
        arrowImage.frame = self.centerButton.frame;
        arrowImage.center = self.centerButton.center;
        arrowImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.centerButton addSubview:arrowImage];
        
        //Add Tap Gesture Recognizer to Center Button
        UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMenu:)];
        [self.centerButton addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat centerX = (self.frame.size.width - self.centerButton.frame.size.width)/2.0f;
    CGFloat centerY = (self.frame.size.height - self.centerButton.frame.size.height)/2.0f;
    self.centerButton.frame = CGRectMake(centerX, centerY, 40.0f, 40.0f);
    self.centerButton.layer.cornerRadius = self.centerButton.frame.size.width/2.0f;
}

#pragma mark - Actions

- (void)didTapMenu:(id)selector
{
    [self rotateCenterButton];
    if (self.isMenuOpen)
    {
        [self.delegate menuBarViewDidTapCloseMenuWithCompletion:^{
            self.isMenuOpen = NO;
        }];
    }
    else
    {
        [self.delegate menuBarViewDidTapOpenMenuWithCompletion:^{
            self.isMenuOpen = YES;
        }];
    }
}

#pragma mark - Animations

- (void)rotateCenterButton
{
    CGFloat radians = atan2f(self.centerButton.transform.b, self.centerButton.transform.a);
    CGFloat degrees = radians * (180 / M_PI);
    CGAffineTransform transform = CGAffineTransformMakeRotation((180 + degrees) * M_PI/180);
    [UIView animateWithDuration:0.4 animations:^{
        self.centerButton.transform = transform;
    }];
}

@end
