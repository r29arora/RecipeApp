//
//  MenuViewController.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>

- (void)menuViewController:(MenuViewController *)menuViewController didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MenuViewController : UIViewController

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) id<MenuViewControllerDelegate> delegate;

@end
