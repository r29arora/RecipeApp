//
//  CreateDirectionsView.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-28.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreateDirectionsView;

@protocol  CreateDirectionsViewDelegate <NSObject>

- (void)didFinishWritingRecipe;

@end

@interface CreateDirectionsView : UIView

@property (nonatomic, strong)UILabel *directionsLabel;
@property (nonatomic, strong)UIView *separatorView;
@property (nonatomic, strong)UITableView *directionsTableView;
@property (nonatomic, strong)UIButton *doneButton;
@property (nonatomic, strong) id <CreateDirectionsViewDelegate> delegate;
@property (nonatomic, readonly) NSMutableArray *directionSections;
@property (nonatomic, readonly) NSMutableArray *directionSectionHeaders;

- (instancetype)init;

@end
