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
        
        self.centerButton = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, self.frame.size.height)];
        self.centerButton.backgroundColor = [UIColor whiteColor];
        self.centerButton.layer.cornerRadius = 4.0f;
        [self addSubview:self.centerButton];
        UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMenu:)];
        [self.centerButton addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

- (void)didTapMenu:(id)selector
{
    CGFloat radians = atan2f(self.centerButton.transform.b, self.centerButton.transform.a);
    CGFloat degrees = radians * (180 / M_PI);
    CGAffineTransform transform = CGAffineTransformMakeRotation((180 + degrees) * M_PI/180);
    [UIView animateWithDuration:0.25 animations:^{
        self.centerButton.transform = transform;
    }];
    
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

- (void)layoutSubviews
{
    CGFloat centerX = (self.frame.size.width - self.centerButton.frame.size.width)/2.0f;
    self.centerButton.frame = CGRectMake(centerX, 0, 80.0f, self.frame.size.height);
}

@end
