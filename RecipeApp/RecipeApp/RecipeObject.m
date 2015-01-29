//
//  RecipeObject.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RecipeObject.h"

@implementation RecipeObject

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        [aDecoder decodeObjectForKey:@"Title"];
        [aDecoder decodeObjectForKey:@"Author"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"Title"];
    [aCoder encodeObject:_author forKey:@"Author"];
}

+ (NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsInDirectory = [paths firstObject];
    return documentsInDirectory;
}

+ (NSString *)dataFilePath:(NSString *)filename
{
//    return [[self documentDirectory] stringByAppendingPathComponent:filename];
    return [[NSBundle mainBundle] pathForResource:@"Recipes" ofType:@"plist"];
}

- (void)saveDataToDisk
{
    NSString *path = [RecipeObject dataFilePath:kRecipeList];
    
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSMutableArray *titleData = root[@"Title"];
    NSMutableArray *authorData = root[@"Author"];
    
    
    [titleData insertObject:_title atIndex:titleData.count];
    [authorData insertObject:_author atIndex:authorData.count];
    
    root[@"Title"] = titleData;
    root[@"Author"] = authorData;
    
    if (![root writeToFile:path atomically:YES])
    {
        NSLog(@"Failed to write to file path %@", path);
    }
}

- (void)loadDataFromDisk
{
    NSString *path = [RecipeObject dataFilePath:kRecipeList];
    
    NSDictionary *root = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"root %@", root);
    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
//    {
//        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        
//        
//        [unarchiver finishDecoding];
//    }
}

@end
