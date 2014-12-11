//
//  Utils.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-12-10.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (BOOL)isIPad
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

@end
