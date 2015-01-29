//
//  RecipeObjectManager.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeObjectManager.h"

@implementation RecipeObjectManager

- (instancetype)init
{
    if (self = [super init])
    {
        self.recipeObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)saveDataToDisk
{
}

- (void)loadDataFromDisk
{

}

@end
