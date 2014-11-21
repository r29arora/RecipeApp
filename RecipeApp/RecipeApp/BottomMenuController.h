//
//  BottomMenuController.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuBarView;
@class MenuViewController;

@protocol BottomMenuControllerDelegate

- (void)bottomMenuControllerDidOpenMenu;
- (void)bottomMenucontrollerDidCloseMenu;
- (void)bottomMenuControllerWillTransition;

@end

@interface BottomMenuController : UIViewController

//Delegate
@property (nonatomic, strong) id <BottomMenuControllerDelegate>delegate;

// Child View Controllers
@property (nonatomic, retain) UIViewController *centerViewController;
@property (nonatomic, retain) MenuViewController *bottomViewController;

// Menu Bar
@property (nonatomic, strong) MenuBarView *menuBarView;

//Other
@property (nonatomic) BOOL isShowingBottomViewController;

//Initializers
- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController;

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController bottomViewController:(UIViewController *)bottomViewController;

//Setup Methods
- (void)setupCenterView;

//Transition Methods
- (void)showBottomMenuController;


@end