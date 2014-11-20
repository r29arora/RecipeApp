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
        
        self.centerButton = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, self.frame.size.height)];
        self.centerButton.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.6];
        [self addSubview:self.centerButton];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
        arrowImage.frame = self.centerButton.frame;
        arrowImage.center = self.centerButton.center;
        arrowImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.centerButton addSubview:arrowImage];
        
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
    [UIView animateWithDuration:0.4 animations:^{
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
    self.centerButton.frame = CGRectMake(centerX, 0, 50.0f, self.frame.size.height);
    self.centerButton.layer.cornerRadius = self.centerButton.frame.size.width/2.0f;


}

@end
