//
//  RecipeCollectionViewCell.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *recipeImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
