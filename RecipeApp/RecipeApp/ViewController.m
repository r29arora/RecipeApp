//
//  ViewController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "ViewController.h"
#import "BottomMenuController.h"
#import "AppDelegate.h"

@interface ViewController () <BottomMenuControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)bottomMenuControllerWillTransition
{
    UIView *dummyOverlayView = [[UIView alloc] initWithFrame:self.view.frame];
    dummyOverlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    [self.view addSubview:dummyOverlayView];
}

- (void)bottomMenuControllerDidOpenMenu
{
    NSLog(@"open menu");
}

@end
