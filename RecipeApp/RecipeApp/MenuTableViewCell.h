//
//  MenuTableViewCell.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell

typedef enum {
    MenuTableViewTypeNewRecipe = 0,
    MenuTableViewTypeMyRecipes,
}MenuTableViewType;

@property (nonatomic, strong) UIImageView *sideImage;
@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
