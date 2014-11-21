//
//  RecipeObject.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeObject.h"

@implementation RecipeObject

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"title"];
}

@end
