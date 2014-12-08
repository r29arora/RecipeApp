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
        [aDecoder decodeObjectForKey:kTitleKey];
        [aDecoder decodeObjectForKey:kAuthorKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:kTitleKey];
    [aCoder encodeObject:_author forKey:kAuthorKey];
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
    
    [root writeToFile:path atomically:YES];
    
    if (completion)
    {
        completion();
    }
}


@end
