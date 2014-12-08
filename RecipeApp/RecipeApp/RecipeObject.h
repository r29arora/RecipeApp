//
//  RecipeObject.h
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-20.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRootKey @"root"
#define kTitleKey @"Title"
#define kAuthorKey @"Author"

#define kDataKey @"Recipe"
#define kDataFile @"Recipe.plist"

@interface RecipeObject : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;

- (void)saveDataToDiskWithCompletion:(void(^)())completion;
+ (NSMutableArray *)loadDataFromDiskWithCompletion:(void(^)())completion
                               failure:(void(^)(NSError *error))failure;
@end
