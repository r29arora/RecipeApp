//
//  BaseNavigationController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-12-10.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

#pragma mark - Initialization

- (instancetype)initWithDetailViewController:(UIViewController *)detailViewController sideViewController:(UIViewController *)sideViewController
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _detailViewController = detailViewController;
        _sideViewController = sideViewController;
    }
    return self;
}

#pragma mark - Set Up Child View Controllers

- (void)setupDetailView
{
    if (!self.detailViewController)
    {
        return;
    }
    
    [self addChildViewController:self.detailViewController];
    [self.view addSubview:self.detailViewController.view];
    [self.detailViewController didMoveToParentViewController:self];
}

- (void)setupSideView
{
    if (!self.sideViewController)
    {
        return;
    }
    
    [self addChildViewController:self.sideViewController];
    [self.view addSubview:self.sideViewController.view];
    [self.sideViewController didMoveToParentViewController:self];
}

- (void)setupViews
{
    [self setupDetailView];
    [self setupSideView];
}

#pragma mark - Replace Detail View

- (void)replaceDetailViewController:(UIViewController *)detailViewController completion:(void(^)())completion
{
    if (self.detailViewController == detailViewController)
    {
        if (completion) {completion();}
        return;
    }
    else
    {
        if (self.detailViewController)
        {
            [self.detailViewController removeFromParentViewController];
            [self.detailViewController.view removeFromSuperview];
        }
        
        self.detailViewController = detailViewController;
        [self setupDetailView];
    }
    
    if (completion) {completion();}
}

#pragma mark - Autorotate

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
