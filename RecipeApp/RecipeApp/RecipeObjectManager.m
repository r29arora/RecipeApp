//
//  RecipeObjectManager.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeObjectManager.h"

@implementation RecipeObjectManager

- (instancetype)init
{
    if (self = [super init])
    {
        self.recipeObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.recipeObjects = [aDecoder decodeObjectForKey:kRecipeObjectsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_recipeObjects forKey:kRecipeObjectsKey];
}

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

- (void)saveDataToDisk
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_recipeObjects forKey:kRecipeObjectsKey];
    [archiver finishEncoding];
    [data writeToFile:[RecipeObjectManager dataFilePath:kFileLocation] atomically:YES];
}

- (void)loadDataFromDisk
{
    NSString *path = [RecipeObjectManager dataFilePath:kFileLocation];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        _recipeObjects = [unarchiver decodeObjectForKey:kRecipeObjectsKey];
        
        if (!_recipeObjects)
        {
            _recipeObjects = [[NSMutableArray alloc] init];
        }
        
        [unarchiver finishDecoding];
    }
}

@end
