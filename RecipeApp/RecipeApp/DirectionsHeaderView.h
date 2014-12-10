//
//  DirectionsHeaderView.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-12-09.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DirectionsHeaderView;
@class RATextField;

@protocol DirectionsHeaderViewDelegate <NSObject>

- (void)directionsHeaderView:(DirectionsHeaderView *)headerView didUpdateHeaderViewInSection:(NSUInteger)sectionNumber;
- (void)directionsHeaderView:(DirectionsHeaderView *)headerView didTapDeleteHeaderViewInSection:(NSUInteger)sectionNumber;

@end

@interface DirectionsHeaderView : UIView

@property (nonatomic) NSUInteger sectionNumber;
@property (nonatomic, strong) RATextField *textField;

@property (nonatomic, strong) id <DirectionsHeaderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame sectionNumber:(NSUInteger)sectionNumber;

@end
