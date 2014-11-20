//
//  MenuTableViewCell.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.sideImage = [[UIImageView alloc] init];
        self.sideImage.frame = CGRectMake(0, 0, 20, 20);
        self.sideImage.contentMode = UIViewContentModeScaleAspectFill;
        self.sideImage.backgroundColor = [UIColor clearColor];
        [self addSubview:self.sideImage];
        
        self.titleLabel = [[UILabel alloc] init];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    self.sideImage.frame = CGRectMake(20, (self.frame.size.height)/2.0f - 10, 20, 20);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.sideImage.frame) + 10, 0, self.frame.size.width - self.sideImage.frame.size.width, self.frame.size.height);
}

@end
