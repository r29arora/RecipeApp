//
//  IngredientsTableViewCell.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-25.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RATextField.h"

@class IngredientsTableViewCell;

@protocol IngredientsTableViewCellDelegate <NSObject>

- (void)didTapAddTextFieldCell:(IngredientsTableViewCell *)cell atIndex:(NSInteger)index;

@end

@interface IngredientsTableViewCell : UITableViewCell

@property (nonatomic, strong) RATextField *textField;
@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL isLastCell;

@property (nonatomic, strong) id <IngredientsTableViewCellDelegate> delegate;

- (void)setupTextField;

@end
