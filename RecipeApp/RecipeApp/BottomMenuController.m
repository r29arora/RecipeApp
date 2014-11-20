//
//  BottomMenuController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "BottomMenuController.h"
#import "MenuBarView.h"

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

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController bottomViewController:(UIViewController *)bottomViewController
{
    if (self = [self initWithCenterViewController:centerViewController])
    {
        self.bottomViewController = bottomViewController;
        self.delegate = (id<BottomMenuControllerDelegate>) self.centerViewController;
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

- (void)setupBottomView
{
    if(!self.bottomViewController)
    {
        return;
    }
    
    self.bottomViewController.view.frame = CGRectMake(0, SCREEN_HEIGHT, self.bottomViewController.view.frame.size.width, self.bottomViewController.view.frame.size.height);
    
    [self addChildViewController:self.bottomViewController];
    [self.view addSubview:self.bottomViewController.view];
    [self.bottomViewController didMoveToParentViewController:self];
}

- (void)setupMenuBar
{
    self.menuBarView = [[MenuBarView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 80.0f, SCREEN_WIDTH, 80.0f)];
    self.menuBarView.backgroundColor = [UIColor blueColor];
    self.menuBarView.delegate = self;
    [self.view addSubview:self.menuBarView];
    [self.view bringSubviewToFront:self.menuBarView];
}

#pragma mark - Moving View Controllers

- (void)moveCenterViewControllerToTop
{
    if ([self respondsToSelector:@selector(bottomMenuControllerWillTransition)])
    {
        [self.delegate bottomMenuControllerWillTransition];

    }
    
    if (!self.centerViewController || !self.bottomViewController)
    {
        return;
    }
    
    self.centerViewController.view.userInteractionEnabled = NO;
    
    CGRect frame = CGRectMake(0, -1.0f*self.bottomViewController.view.frame.size.height , SCREEN_WIDTH, SCREEN_HEIGHT);
    CGRect frame2 = CGRectMake(0, SCREEN_HEIGHT - self.bottomViewController.view.frame.size.height, self.bottomViewController.view.frame.size.width, self.bottomViewController.view.frame.size.height);
    CGRect frameMenu = CGRectMake(0, SCREEN_HEIGHT - self.bottomViewController.view.frame.size.height - self.menuBarView.frame.size.height, self.menuBarView.frame.size.width, self.menuBarView.frame.size.height);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.centerViewController.view.frame = frame;
        self.bottomViewController.view.frame = frame2;
        self.menuBarView.frame = frameMenu;
        self.isShowingBottomViewController = YES;
        if ([self respondsToSelector:@selector(bottomMenuControllerDidOpenMenu)])
        {
            [self.delegate bottomMenuControllerDidOpenMenu];
        }
    }];
}

- (void)moveCenterViewControllerToOriginalPosition
{
    if (!self.isShowingBottomViewController)
    {
        return;
    }

    [UIView animateWithDuration:0.25 animations:^{
        
        self.centerViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.menuBarView.frame = CGRectMake(0, SCREEN_HEIGHT - self.menuBarView.frame.size.height, SCREEN_WIDTH, self.menuBarView.frame.size.height);
        self.bottomViewController.view.frame = CGRectMake(0, SCREEN_HEIGHT, self.bottomViewController.view.frame.size.width, self.bottomViewController.view.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        self.isShowingBottomViewController = NO;
        [self.bottomViewController removeFromParentViewController];
        [self.bottomViewController.view removeFromSuperview];
        if ([self respondsToSelector:@selector(bottomMenucontrollerDidCloseMenu)])
        {
            [self.delegate bottomMenucontrollerDidCloseMenu];
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
    [self moveCenterViewControllerToOriginalPosition];
    completion();
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
