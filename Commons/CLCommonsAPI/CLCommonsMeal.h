//
//  CLCommonsMeal.h
//  CommonsMenu
//
//  Created by Jan Hennings on 12/21/13.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - CLCommons enums

typedef NS_ENUM(NSInteger, CLCommonsMealTag) {
    CLCommonsMealTagAlcohol,
    CLCommonsMealTagBeef,
    CLCommonsMealTagCampusVital,
    CLCommonsMealTagFish,
    CLCommonsMealTagLactoseFree,
    CLCommonsMealTagPork,
    CLCommonsMealTagPoultry,
    CLCommonsMealTagVegan,
    CLCommonsMealTagVegetarian,
};

#pragma mark - Tag image constants
static NSString* const CLTagIMGAlcohol = @"/uploads/icons/74187548f2da18c6dd641f5e8a50c23d7a66e974.png";
static NSString* const CLTagIMGBeef = @"/uploads/icons/e9a8e409409cf3ff7a40855d08e89097d6168e29.png";
static NSString* const CLTagIMGCampusVital = @"/uploads/icons/3f22ffe877b0caf67318e48fed1d77d18b5e6ce2.png";
static NSString* const CLTagIMGFish = @"/uploads/icons/66175e4b4c7402f3badaabeffdf39316a74e1edb.png";
static NSString* const CLTagIMGLactoseFree = @"/uploads/icons/a77e0a40d4ef2cdce578538758710c9c59548207.png";
static NSString* const CLTagIMGPork = @"/uploads/icons/605801019ea63cf45702f2a2beb9cb9fc64b6b07.png";
static NSString* const CLTagIMGPoultry = @"/uploads/icons/636506d11657da1d9d85fc04e0230ab111954912.png";
static NSString* const CLTagIMGVegan = @"/uploads/icons/0e5bab8a7d0af8f5bdbaa75dc217ed76a6186584.png";
static NSString* const CLTagIMGVegetarian = @"/uploads/icons/37beeeef680a6791f97fe5a5da5f9ef5548a4ee9.png";

@interface CLCommonsMeal : NSObject

#pragma mark - Readonly API

// Name of the meal
@property (nonatomic, readonly) NSString *description;

// Name of the category of the meal
@property (nonatomic, readonly) NSString *category;

// Array with two NSNumber objects representing the prices
// First object: Price for students
// Second object: Price for public servants
@property (nonatomic, readonly) NSArray *prices;

// Array with CLCommonsMealTags (if given)
@property (nonatomic, readonly) NSArray *tags;


#pragma mark - Initializers

- (instancetype)initWithDescription:(NSString *)aDescription category:(NSString *)aCategory prices:(NSArray *)pricesArray tags:(NSArray *)tagsArray;

@end