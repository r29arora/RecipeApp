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
    
    root[kTitleKey] = titleData;
    root[kAuthorKey] = authorData;
    
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
    
    [titleData insertObject:self.title atIndex:titleData.count];
    [authorData insertObject:self.author atIndex:authorData.count];
    
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
    
    if (titleData.count != authorData.count)
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
        [recipeObjects insertObject:recipe atIndex:recipeObjects.count];
    }
    
    if (completion)
    {
        completion();
    }
    
    return recipeObjects;
}

@end
