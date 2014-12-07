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

    //Recipe Object Manager setup
    self.recipeObjectManager = [[RecipeObjectManager alloc] init];
    
    // View setup
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(self.view.frame.size.width - 20.0f , 150.0f)];
    
    // Collection View setup
    self.recipeList = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0f, 25.0f, self.view.frame.size.width - 20.0f, self.view.frame.size.height - 75.0f) collectionViewLayout:layout];
    self.recipeList.delegate = self;
    self.recipeList.dataSource = self;
    self.recipeList.backgroundColor = [UIColor clearColor];
    [self.recipeList registerClass:[RecipeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.recipeList];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Reload the data source from disk when the view will appear
    [self.recipeObjectManager loadDataFromDisk];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[RecipeCollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    RecipeObject *currentRecipe = (RecipeObject *)self.recipeObjectManager.recipeObjects[indexPath.row];
    
    cell.titleLabel.text = currentRecipe.title;
    cell.authorLabel.text = currentRecipe.author;
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
