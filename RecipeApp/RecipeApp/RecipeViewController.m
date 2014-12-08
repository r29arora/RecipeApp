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
#import "CreateRecipeViewController.h"

@interface RecipeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CreateRecipeViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *recipeObjects;

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.recipeObjects = [[NSMutableArray alloc] init];
    
    // View setup
    self.view.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:170.0f/255.0f blue:220.0f/255.0f alpha:0.8f];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(self.view.frame.size.width - 20.0f , 100.0f)];
    
    // Collection View setup
    self.recipeList = [[UICollectionView alloc] initWithFrame:CGRectMake(10.0f, 25.0f, self.view.frame.size.width - 20.0f, self.view.frame.size.height - 65.0f) collectionViewLayout:layout];
    self.recipeList.delegate = self;
    self.recipeList.dataSource = self;
    self.recipeList.backgroundColor = [UIColor clearColor];
    self.recipeList.showsVerticalScrollIndicator = NO;
    self.recipeList.showsHorizontalScrollIndicator = NO;
    [self.recipeList registerClass:[RecipeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.recipeList];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Reload the data source from disk when the view will appear
    self.recipeObjects = [RecipeObject loadDataFromDiskWithCompletion:^{
        // completion
        NSLog(@"success");
    } failure:^(NSError *error) {
        // handle Error
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

#pragma mark - UICollectionViewCellDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[RecipeCollectionViewCell alloc] init];
    }
    cell.backgroundColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:0.3f];
    
    RecipeObject *currentRecipe = self.recipeObjects[indexPath.row];
    cell.titleLabel.text = currentRecipe.title;
    cell.authorLabel.text = currentRecipe.author;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(RecipeViewController:didSelectRecipeAtIndexPath:)])
    {
        [self.delegate RecipeViewController:self didSelectRecipeAtIndexPath:indexPath];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.recipeObjects.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

#pragma mark - CreateRecipeViewControllerDelegate

- (void)createRecipeViewControllerDidFinishEditing
{
    self.recipeObjects = [RecipeObject loadDataFromDiskWithCompletion:^{
        // Success
        NSLog(@"success");
    } failure:^(NSError *error) {
        // Failure
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    [self.recipeList reloadData];
}

@end
