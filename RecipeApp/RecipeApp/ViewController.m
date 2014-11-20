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
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)bottomMenuControllerWillTransition
{
    NSLog(@"Will Transition");
}

- (void)bottomMenucontrollerDidCloseMenu
{
    NSLog(@"Close Menu");
}

- (void)bottomMenuControllerDidOpenMenu
{
    NSLog(@"Open Menu");
}

@end
