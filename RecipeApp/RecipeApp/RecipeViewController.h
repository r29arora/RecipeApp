//
//  RecipeViewController.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecipeViewController;

@protocol RecipeViewControllerDelegate <NSObject>

- (void)RecipeViewController:(RecipeViewController *)controller didSelectRecipeAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface RecipeViewController : UIViewController

@property (nonatomic, strong) UICollectionView *recipeList;
@property (nonatomic, strong) id <RecipeViewControllerDelegate> delegate;

@end
