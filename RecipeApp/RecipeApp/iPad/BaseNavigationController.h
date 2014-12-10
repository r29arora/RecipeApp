//
//  BaseNavigationController.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-12-10.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UIViewController

@property (nonatomic, retain) UIViewController *detailViewController;
@property (nonatomic, retain) UIViewController *sideViewController;

- (instancetype)initWithDetailViewController:(UIViewController *)detailViewController sideViewController:(UIViewController *)sideViewController;

- (void)setupViews;
- (void)replaceDetailViewController:(UIViewController *)detailViewController completion:(void(^)())completion;
@end
