//
//  UIView+Shadow.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)createShadow
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 4.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
}

@end
