//
//  DirectionsTableViewCell.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-28.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DirectionsTableViewCell;

@protocol DirectionsTableViewCellDelegate <NSObject>

- (void)directionsTableViewCell:(DirectionsTableViewCell *)cell didTapAddDirectionButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)directionsTableViewCell:(DirectionsTableViewCell *)cell didTapAddSectionButtonAtIndexPath:(NSIndexPath *)indexPath;
- (void)directionsTableViewCell:(DirectionsTableViewCell *)cell didFinishEditingAtIndexPath:(NSIndexPath *)indexPath;
- (void)directionsTableViewCell:(DirectionsTableViewCell *)cell didChangeTextViewAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DirectionsTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextView *directionTextView;
@property (nonatomic, strong) UIButton *addDirectionButton;
@property (nonatomic, strong) UIButton *addSectionButton;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) id <DirectionsTableViewCellDelegate> delegate;

- (void)setupDirectionTextView;
- (void)setupAddDirectionButton;
- (void)setupAddSectionButton;

@end
