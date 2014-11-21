//
//  CreateIngredientsView.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateIngredientsView : UIView

@property (nonatomic, strong) UILabel *ingredientsLabel;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UITextView *ingredientsTextView;

- (instancetype)init;

@end
