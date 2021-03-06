//
//  BottomMenuController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "BottomMenuController.h"
#import "MenuBarView.h"
#import "MenuViewController.h"
#import "CreateRecipeViewController.h"
#import "RecipeViewController.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

@interface BottomMenuController () <MenuBarViewDelegate>

@end

@implementation BottomMenuController

#pragma mark -  Public Initializer Methods

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        self.centerViewController = centerViewController;
    }
    return self;
}

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController bottomViewController:(MenuViewController *)bottomViewController
{
    if (self = [self initWithCenterViewController:centerViewController])
    {
        self.bottomViewController = bottomViewController;
    }
    return self;
}

#pragma mark - Set Up Child View Controllers

- (void)setupCenterView
{
    if (!self.centerViewController)
    {
        return;
    }
    
    [self addChildViewController:self.centerViewController];
    [self.view addSubview:self.centerViewController.view];
    [self.centerViewController didMoveToParentViewController:self];
    
    [self setupMenuBar];
}

- (void)setNewCenterViewController:(UIViewController *)centerViewController WithCompletion:(void (^)())completion
{
    if (self.centerViewController == centerViewController)
    {
        if (completion)
        {
            completion();
        }
        return;
    }
    //Close Menu if open
    if (self.isShowingBottomViewController)
    {
        [self menuBarViewDidTapCloseMenuWithCompletion:^{
            self.menuBarView.isMenuOpen = NO;
            self.isShowingBottomViewController = NO;
            [self setCenterViewWithNewViewController:centerViewController];
        }];
    }
    else
    {
        [self setCenterViewWithNewViewController:centerViewController];
    }
    
    if (completion)
    {
        
        completion();
    }
}

- (void)setCenterViewWithNewViewController:(UIViewController *)centerViewController
{
    if (self.centerViewController)
    {
        [self.centerViewController removeFromParentViewController];
        [self.centerViewController.view removeFromSuperview];
    }
    self.centerViewController = centerViewController;
    
    [self setupCenterView];
}

- (void)setupBottomView
{
    if(!self.bottomViewController)
    {
        return;
    }
    
    self.bottomViewController.view.frame = CGRectMake(0, SCREEN_HEIGHT, self.bottomViewController.view.frame.size.width, self.bottomViewController.view.frame.size.height);
    self.bottomViewController.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:self.bottomViewController];
    [self.view addSubview:self.bottomViewController.view];
    [self.bottomViewController didMoveToParentViewController:self];
}

- (void)setupMenuBar
{
    self.menuBarView = [[MenuBarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50.0f, SCREEN_WIDTH, 50.0f)];
    self.menuBarView.backgroundColor = [UIColor clearColor];
    self.menuBarView.delegate = self;
    [self.view addSubview:self.menuBarView];
    [self.view bringSubviewToFront:self.menuBarView];
}

#pragma mark - Moving View Controllers

- (void)moveCenterViewControllerToTop
{
    if (!self.centerViewController || !self.bottomViewController)
    {
        return;
    }
    
    self.centerViewController.view.userInteractionEnabled = NO;
    
    CGRect frame2 = CGRectMake(0, SCREEN_HEIGHT - self.bottomViewController.view.frame.size.height, self.bottomViewController.view.frame.size.width, self.bottomViewController.view.frame.size.height);
    CGRect frameMenu = CGRectMake(0, SCREEN_HEIGHT - self.bottomViewController.view.frame.size.height - self.menuBarView.frame.size.height, self.menuBarView.frame.size.width, self.menuBarView.frame.size.height);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomViewController.view.frame = frame2;
        self.menuBarView.frame = frameMenu;
        self.isShowingBottomViewController = YES;
        [self.delegate bottomMenuControllerDidOpenMenu];
    }];
}

- (void)moveCenterViewControllerToOriginalPositionWithCompletion:(void (^) ())completion
{
    if (!self.isShowingBottomViewController)
    {
        return;
    }
    
    self.centerViewController.view.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.centerViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.menuBarView.frame = CGRectMake(0, SCREEN_HEIGHT - self.menuBarView.frame.size.height, SCREEN_WIDTH, self.menuBarView.frame.size.height);
        self.bottomViewController.view.frame = CGRectMake(0, SCREEN_HEIGHT, self.bottomViewController.view.frame.size.width, self.bottomViewController.view.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        self.isShowingBottomViewController = NO;
        self.menuBarView.isMenuOpen = NO;
        [self.bottomViewController removeFromParentViewController];
        [self.bottomViewController.view removeFromSuperview];
        [self.delegate bottomMenucontrollerDidCloseMenu];
        
        if (completion)
        {
            completion();
        }
        
    }];
}

- (void)showBottomMenuController
{
    [self setupBottomView];
    [self moveCenterViewControllerToTop];
}

#pragma mark - MenuBarViewDelegate

- (void)menuBarViewDidTapOpenMenuWithCompletion:(void (^)())completion
{
    if (self.isShowingBottomViewController)
    {
        return;
    }
    [self showBottomMenuController];
    completion();
}

- (void)menuBarViewDidTapCloseMenuWithCompletion:(void (^)())completion
{
    if (!self.isShowingBottomViewController)
    {
        return;
    }
    [self moveCenterViewControllerToOriginalPositionWithCompletion:^{
        if (completion)
        {
            completion();
        }
    }];
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
