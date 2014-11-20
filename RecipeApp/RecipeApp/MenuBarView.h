//
//  MenuBarView.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-19.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomMenuController.h"

@protocol MenuBarViewDelegate <NSObject>

- (void)menuBarViewDidTapOpenMenuWithCompletion:(void(^)())completion;
- (void)menuBarViewDidTapCloseMenuWithCompletion:(void(^)())completion;

@end

@interface MenuBarView : UIView

@property (nonatomic, strong) UIView *centerButton;
@property (nonatomic, strong) id <MenuBarViewDelegate> delegate;
@property (nonatomic) BOOL isMenuOpen;

- (instancetype)initWithFrame:(CGRect)frame;

@end
