//
//  CreateTitleView.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateTitleView : UIView <UITextViewDelegate>

@property (nonatomic, strong) UITextView *titleLabel;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UITextView *authorLabel;

- (instancetype)init;

@end
