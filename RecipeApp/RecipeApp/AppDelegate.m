//
//  AppDelegate.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "AppDelegate.h"
#import "BottomMenuController.h"
#import "MenuViewController.h"
#import "RecipeViewController.h"
#import "CreateRecipeViewController.h"
#import "MenuBarView.h"
#import "RecipeDetailViewController.h"
#import "Constants.h"
#import "BaseNavigationController.h"
#import "CreateRecipesViewController_iPad.h"
#import "MyRecipesViewController.h"
#import "SideNavigationViewController.h"
#import "Utils.h"
#import "MenuTableViewCell.h"

@interface AppDelegate () <BottomMenuControllerDelegate, CreateRecipeViewControllerDelegate, MenuViewControllerDelegate, RecipeViewControllerDelegate>

// IPhone View Controllers
@property (nonatomic, strong) BottomMenuController *bottomMenuController;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) RecipeDetailViewController *detailViewController;
@property (nonatomic, strong) RecipeViewController *mainViewController;
@property (nonatomic, strong) CreateRecipeViewController *createRecipeViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setupBottomMenuController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Set Up BottomMenuController

- (void)setupBottomMenuController
{
    self.mainViewController = [[RecipeViewController alloc] init];
    self.menuViewController = [[MenuViewController alloc] init];
    self.createRecipeViewController = [[CreateRecipeViewController alloc] init];
    self.detailViewController = [[RecipeDetailViewController alloc] init];
    
    self.createRecipeViewController.delegate = self;
    self.menuViewController.delegate = self;
    self.mainViewController.delegate = self;
    self.bottomMenuController.delegate = self;
    
    self.mainViewController.view.frame = CGRectMake(0, 0, [Utils screenWidth], [Utils screenHeight]);
    self.detailViewController.view.frame = CGRectMake(0, 0, [Utils screenWidth], [Utils screenHeight]);
    self.menuViewController.view.frame = CGRectMake(0, 0, [Utils screenWidth] , 100.0f);
    self.bottomMenuController = [[BottomMenuController alloc] initWithCenterViewController:self.mainViewController bottomViewController:self.menuViewController];
    [self.bottomMenuController setupCenterView];
    
    self.window.rootViewController = self.bottomMenuController;
    [self.window makeKeyAndVisible];
}

#pragma mark -CreateRecipeViewControllerDelegate

- (void)createRecipeViewControllerDidFinishEditing
{
    self.mainViewController.view.frame = CGRectMake(0, 0, [Utils screenWidth], [Utils screenHeight]);
    [self.bottomMenuController setNewCenterViewController:self.mainViewController WithCompletion:nil];
    [self.mainViewController.recipeList reloadData];
}

#pragma mark - RecipeViewControllerDelegate
- (void)recipeViewController:(RecipeViewController *)controller
             didSelectRecipe:(RecipeObject *)recipe
                 AtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController = [[RecipeDetailViewController alloc] init];
    self.detailViewController.recipeObject = recipe;
    self.detailViewController.view.frame = CGRectMake(0, 0, [Utils screenWidth], [Utils screenHeight]);
    [self.bottomMenuController setNewCenterViewController:self.detailViewController WithCompletion:nil];
}

#pragma mark - MenuViewControllerDelegate

- (void)menuViewController:(MenuViewController *)menuViewController didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == MenuTableViewTypeNewRecipe && ![self.bottomMenuController.centerViewController isKindOfClass:[CreateRecipeViewController class]])
    {
        self.createRecipeViewController = [[CreateRecipeViewController alloc] init];
        self.createRecipeViewController.delegate = self;
        self.createRecipeViewController.view.frame = CGRectMake(0, 0, [Utils screenWidth], [Utils screenHeight]);
        [self.bottomMenuController setNewCenterViewController:self.createRecipeViewController WithCompletion:nil];
        return;
    }
    else if (indexPath.row == MenuTableViewTypeMyRecipes && ![self.bottomMenuController.centerViewController isKindOfClass:[RecipeViewController class]])
    {
        self.mainViewController.view.frame = CGRectMake(0, 0, [Utils screenWidth], [Utils screenHeight]);
        [self.bottomMenuController setNewCenterViewController:self.mainViewController WithCompletion:nil];
        return;
    }
    else
    {
        [self.bottomMenuController moveCenterViewControllerToOriginalPositionWithCompletion:^{
            self.bottomMenuController.isShowingBottomViewController = NO;
            self.bottomMenuController.menuBarView.isMenuOpen = NO;
        }];
    }
}

@end
