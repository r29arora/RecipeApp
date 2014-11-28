//
//  RecipeObjectManager.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFileLocation           @"RecipeObject.plist"
#define kRecipeObjectsKey       @"recipeObjects"

@interface RecipeObjectManager : NSObject <NSCoding>

@property (nonatomic, strong) NSMutableArray *recipeObjects;

- (instancetype)init;

- (void)saveDataToDisk;
- (void)loadDataFromDisk;

@end
