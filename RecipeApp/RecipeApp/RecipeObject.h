//
//  RecipeObject.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRecipeList @"Recipes.plist"

@interface RecipeObject : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;

- (void)saveDataToDisk;
- (void)loadDataFromDisk;

@end
