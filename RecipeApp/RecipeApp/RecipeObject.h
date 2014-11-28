//
//  RecipeObject.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeObject : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSMutableArray *ingredients;
@property (nonatomic, strong) NSMutableArray *directions;

@end
