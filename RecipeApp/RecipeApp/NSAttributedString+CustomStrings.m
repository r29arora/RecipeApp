//
//  NSAttributedString+CustomStrings.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-12-10.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "NSAttributedString+CustomStrings.h"
#import "NSAttributedString+Utils.h"

@implementation NSAttributedString (CustomStrings)

+ (NSAttributedString *)underlinedString:(NSString *)string
{
    NSMutableAttributedString *underlinedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange stringRange = NSMakeRange(0, [underlinedString length]);
    [underlinedString setUnderline:YES range:stringRange];
    return [underlinedString copy];
}

@end
