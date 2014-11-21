//
//  RecipeViewController.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeCollectionViewCell.h"
#import "RecipeObject.h"

@interface RecipeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.recipeObjectManager = [[RecipeObjectManager alloc] init];
    [self.recipeObjectManager loadDataFromDisk];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(self.view.frame.size.width/2.0f - 20.0f , 200.0f)];
    self.recipeList = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0f, 20.0f, self.view.frame.size.width - 20.0f, self.view.frame.size.height - 70.0f) collectionViewLayout:layout];
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
    cell.titleLabel.text = @"Title Label";
    cell.descriptionLabel.text = @"description Label";
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.recipeObjectManager.recipeObjects.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

@end
