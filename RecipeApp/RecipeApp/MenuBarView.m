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
        self.menuBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        [self.containerView addSubview:self.menuBar];
        
        //Setup Menu button
        self.centerButton = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0f, 40.0f)];
        self.centerButton.backgroundColor = [UIColor whiteColor];
        self.centerButton.layer.borderColor = [[UIColor blackColor] CGColor];
        self.centerButton.layer.borderWidth = 2.0f;
        [self.containerView addSubview:self.centerButton];
        
        //Setup Arrow Icon
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
        arrowImage.frame = CGRectMake(self.centerButton.frame.origin.x + 5.0f, self.centerButton.frame.origin.y + 5.0f, self.centerButton.frame.size.width - 10.0f, self.centerButton.frame.size.height - 10.0f);
        arrowImage.center = self.centerButton.center;
        arrowImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.centerButton addSubview:arrowImage];
        
        //Add Tap and Swipe Gesture Recognizer to Center Button and menu bar
        UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMenu:)];
        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMenu:)];
        UISwipeGestureRecognizer *swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        
        [self.centerButton addGestureRecognizer:swipeGestureRecognizer];
        [self.centerButton addGestureRecognizer:tapGestureRecognizer];
        [self.centerButton addGestureRecognizer:swipeDownGestureRecognizer];
        
        UIGestureRecognizer *tapMenuGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMenu:)];
        UISwipeGestureRecognizer *swipeMenuUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMenu:)];
        swipeMenuUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        UISwipeGestureRecognizer *swipeMenuDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
        swipeMenuDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        
        [self.menuBar addGestureRecognizer:tapMenuGestureRecognizer];
        [self.menuBar addGestureRecognizer:swipeMenuUpGestureRecognizer];
        [self.menuBar addGestureRecognizer:swipeMenuDownGestureRecognizer];
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

- (void)didSwipeDown:(id)selector
{
    if (self.isMenuOpen)
    {
        [self rotateCenterButton];
        [self.delegate menuBarViewDidTapCloseMenuWithCompletion:^{
            self.isMenuOpen = NO;
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
