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

- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didTapAddTextFieldButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didTapAddSectionButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didFinishEditingAtIndexPath:(NSIndexPath *)indexPath;
- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didChangeCharactersAtIndexPath:(NSIndexPath *)indexPath;
- (void)ingredientsTableViewCell:(IngredientsTableViewCell *)cell didTapReturnAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface IngredientsTableViewCell : UITableViewCell

@property (nonatomic, strong) RATextField *textField;
@property (nonatomic, strong) UIButton *addTextFieldButton;
@property (nonatomic ,strong) UIButton *addSectionButton;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic) BOOL isLastCell;

@property (nonatomic, strong) id <IngredientsTableViewCellDelegate> delegate;

- (void)setupTextField;
- (void)replaceTextFieldWithAddRowButton;
- (void)replaceTextFieldWithAddSectionButton;
@end
