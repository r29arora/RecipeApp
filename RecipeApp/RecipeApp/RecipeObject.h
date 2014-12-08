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
#define kIngredientsKey @"Ingredients"
#define kIngredientSectionsKey @"IngredientSection"
#define kDirectionsKey @"Directions"
#define kDirectionSectionsKey @"DirectionSection"

#define kDataKey @"Recipe"
#define kDataFile @"Recipe.plist"

@interface RecipeObject : NSObject

// Title
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;

// Ingredients
@property (nonatomic, strong) NSMutableArray *ingredients;
@property (nonatomic, strong) NSMutableArray *ingredientSections;

//Directions
@property (nonatomic, strong) NSMutableArray *directions;
@property (nonatomic, strong) NSMutableArray *directionSections;


- (void)saveDataToDiskWithCompletion:(void(^)())completion;
+ (NSMutableArray *)loadDataFromDiskWithCompletion:(void(^)())completion
                               failure:(void(^)(NSError *error))failure;
@end
