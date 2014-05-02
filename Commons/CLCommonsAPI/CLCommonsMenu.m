//
//  CLCommonsMenu.m
//  CommonsMenu
//
//  Created by Jan Hennings on 12/22/13.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "CLCommonsMenu.h"

@interface CLCommonsMenu ()

// redeclaration for read/write access
@property (nonatomic) NSString *commons;
@property (nonatomic) NSString *date;
@property (nonatomic) NSArray *meals;

@end

@implementation CLCommonsMenu

#pragma mark - Initializers

- (instancetype)initWithCommons:(NSString *)aCommons date:(NSString *)aDate meals:(NSArray *)mealsArray {
    self = [super init];
    
    if (self) {
        _commons = aCommons;
        _date = aDate;
        _meals = mealsArray;
    }
    
    return self;
}

#pragma mark - Public helper methods

- (void)logMenu {
    NSMutableString *meals = [NSMutableString string];
    NSInteger index = 1;
    
    for (CLCommonsMeal *meal in self.meals) {
        NSString *mealPrices = [NSString stringWithFormat:@"Students: %@ || Public servants: %@", [meal.prices firstObject], [meal.prices lastObject]];
        
        NSMutableString *mealTags;
        for (NSNumber *tag in meal.tags) {
            if (!mealTags) {
                mealTags = [NSMutableString stringWithFormat:@"%@", [CLCommonsMenu tagToString:[tag integerValue]]];
            }
            else {
                [mealTags appendString:[NSString stringWithFormat:@", %@", [CLCommonsMenu tagToString:[tag integerValue]]]];
            }
        }
        
        NSString *temp = [NSString stringWithFormat:@"[#%ld]\nCategory: %@\nDescription: %@\nPrices: %@\nTags: %@\n\n", index++, meal.category, meal.description, mealPrices, mealTags];
        [meals appendString:temp];
    }
    
    NSLog(@"%@", [NSString stringWithFormat:@"\n%@ [%@]:\n\n%@", self.commons, self.date, meals]);
}

-(CLCommonsMenu *) filteredMenuUsingTags:(NSArray *)tags
{
    NSMutableArray *filteredMeals = [[NSMutableArray alloc] init];
    
    for (CLCommonsMeal *meal in self.meals) {
        BOOL shouldAdd = YES;
        for (NSNumber *tag in tags) {
            if (![meal.tags containsObject: tag]) {
                shouldAdd = NO;
            }
        }
        
        if (shouldAdd) {
            [filteredMeals addObject:meal];
        }
    }
    
    CLCommonsMenu *filteredMenu = [[CLCommonsMenu alloc] initWithCommons:self.commons date:self.date meals:filteredMeals];
 
    return filteredMenu;
}

#pragma mark - Private helper methods

+ (NSString *)tagToString:(CLCommonsMealTag)tag {
    NSString *stringTag;
    
    switch (tag) {
        case CLCommonsMealTagAlcohol:
            stringTag = @"Alcohol";
            break;
        case CLCommonsMealTagBeef:
            stringTag = @"Beef";
            break;
        case CLCommonsMealTagCampusVital:
            stringTag = @"CampusVital";
            break;
        case CLCommonsMealTagFish:
            stringTag = @"Fish";
            break;
        case CLCommonsMealTagLactoseFree:
            stringTag = @"LactoseFree";
            break;
        case CLCommonsMealTagPork:
            stringTag = @"Pork";
            break;
        case CLCommonsMealTagPoultry:
            stringTag = @"Poultry";
            break;
        case CLCommonsMealTagVegan:
            stringTag = @"Vegan";
            break;
        case CLCommonsMealTagVegetarian:
            stringTag = @"Vegetarian";
            break;
        default:
            stringTag = @"Error occurred";
            break;
    }
    
    return stringTag;
}

@end