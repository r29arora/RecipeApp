//
//  IngredientsSectionHeaderView.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-25.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RATextField;
@class IngredientsSectionHeaderView;

@protocol  IngredientsSectionHeaderViewDelegate <NSObject>

- (void)ingredientsSectionHeaderView:(IngredientsSectionHeaderView *)headerView didUpdateHeaderViewInSection:(NSInteger)section;

@end

@interface IngredientsSectionHeaderView : UIView

@property (nonatomic) NSInteger sectionNumer;
@property (nonatomic, strong) RATextField *textField;

@property (nonatomic, strong) id <IngredientsSectionHeaderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame sectionNumber:(NSInteger)sectionNumber;

@end
