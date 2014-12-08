//
//  RecipeViewController.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeViewController : UIViewController

@property (nonatomic, strong) UICollectionView *recipeList;
@property (nonatomic, strong) NSCoder *coder;
@end
