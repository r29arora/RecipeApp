//
//  RecipeViewController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeCollectionViewCell.h"

@interface RecipeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(self.view.frame.size.width - 20.0f, 250.0f)];
    self.recipeList = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20.0f, self.view.frame.size.width, self.view.frame.size.height - 60.0f) collectionViewLayout:layout];
    self.recipeList.delegate = self;
    self.recipeList.dataSource = self;
    self.recipeList.backgroundColor = [UIColor clearColor];
    [self.recipeList registerClass:[RecipeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.recipeList];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

@end
