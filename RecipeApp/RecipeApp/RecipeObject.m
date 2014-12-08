//
//  RecipeObject.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeObject.h"

@implementation RecipeObject


+ (NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsInDirectory = [paths firstObject];
    return documentsInDirectory;
}

+ (NSString *)dataFilePath:(NSString *)filename
{
    return [[self documentDirectory] stringByAppendingPathComponent:filename];
}

+ (NSMutableDictionary *)createPropertyList
{
    NSMutableDictionary *root = [[NSMutableDictionary alloc] init];
    NSMutableArray *titleData = [[NSMutableArray alloc] init];
    NSMutableArray *authorData = [[NSMutableArray alloc] init];
    NSMutableArray *ingredientsData = [[NSMutableArray alloc] init];
    NSMutableArray *ingredientSectionData = [[NSMutableArray alloc] init];
    NSMutableArray *directionsData = [[NSMutableArray alloc] init];
    NSMutableArray *directionSectionData = [[NSMutableArray alloc] init];
    
    root[kTitleKey] = titleData;
    root[kAuthorKey] = authorData;
    
    root[kIngredientsKey] = ingredientsData;
    root[kIngredientSectionsKey] = ingredientSectionData;
    
    root[kDirectionsKey] = directionsData;
    root[kDirectionSectionsKey] = directionSectionData;
    
    return root;
}

- (void)saveDataToDiskWithCompletion:(void(^)())completion
{
    NSString *path = [RecipeObject dataFilePath:kDataFile];
    NSMutableDictionary *root;
    
    // file exists at path
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        root = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    }
    // file does not exist at path
    else
    {
        root = [RecipeObject createPropertyList];
    }
    
    NSMutableArray *titleData = root[kTitleKey];
    NSMutableArray *authorData = root[kAuthorKey];
    NSMutableArray *ingredientsData = root[kIngredientsKey];
    NSMutableArray *ingredientSectionData = root[kIngredientSectionsKey];
    NSMutableArray *directionsData = root[kDirectionsKey];
    NSMutableArray *directionsSectionData = root[kDirectionSectionsKey];
    
    [titleData insertObject:self.title atIndex:titleData.count];
    [authorData insertObject:self.author atIndex:authorData.count];
    [ingredientsData insertObject:self.ingredients atIndex:ingredientsData.count];
    [ingredientSectionData insertObject:self.ingredientSections atIndex:ingredientSectionData.count];
    [directionsData insertObject:self.directions atIndex:directionsData.count];
    [directionsSectionData insertObject:self.directions atIndex:directionsSectionData.count];
    
    if ([root writeToFile:path atomically:YES])
    {
        if (completion)
        {
            completion();
        }
    }
}

+ (NSMutableArray *)loadDataFromDiskWithCompletion:(void(^)())completion
                               failure:(void(^)(NSError *error))failure
{
    NSString *path = [RecipeObject dataFilePath:kDataFile];
    NSMutableDictionary *root;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        root = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    }
    NSError *error;
    // file does not exist
    if (!root)
    {
        if (failure)
        {
            error = [NSError errorWithDomain:@"plist Not found!" code:404 userInfo:nil];
            failure(error);
        }
    }
    
    // Need to do something with this..
    NSMutableArray *titleData = root[kTitleKey];
    NSMutableArray *authorData = root[kAuthorKey];
    NSMutableArray *ingredientsData = root[kIngredientsKey];
    NSMutableArray *ingredientSectionData = root[kIngredientSectionsKey];
    NSMutableArray *directionsData = root[kDirectionsKey];
    NSMutableArray *directionSectionData = root[kDirectionSectionsKey];
    
    // Invalidate if plist entries do not line up
    if (titleData.count != authorData.count ||
        titleData.count != ingredientsData.count ||
        titleData.count != ingredientSectionData.count ||
        titleData.count != directionsData.count ||
        titleData.count != directionSectionData.count)
    {
        if (failure)
        {
            error = [NSError errorWithDomain:@"data inconsistency!" code:100 userInfo:nil];
            failure(error);
        }
    }
    
    NSMutableArray *recipeObjects = [[NSMutableArray alloc] init];
    
    for (NSUInteger x = 0; x < titleData.count; x++)
    {
        RecipeObject *recipe = [[RecipeObject alloc] init];
        recipe.title = titleData[x];
        recipe.author = authorData[x];
        recipe.ingredients = ingredientsData[x];
        recipe.ingredientSections = ingredientSectionData[x];
        recipe.directions = directionsData[x];
        recipe.directionSections = directionsData[x];
        [recipeObjects insertObject:recipe atIndex:recipeObjects.count];
    }
    
    if (completion)
    {
        completion();
    }
    
    return recipeObjects;
}

@end
