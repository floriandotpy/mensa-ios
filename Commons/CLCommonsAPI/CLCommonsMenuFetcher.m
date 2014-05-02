//
//  CLCommonsMenuFetcher.m
//  CommonsMenu
//
//  Created by Jan Hennings on 12/22/13.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "CLCommonsMenuFetcher.h"
#import "HTMLParser.h"

#pragma mark - NSString class extension

@implementation NSString (trimWhitespaces)

- (NSString *)stringByTrimmingWhitespaces {
    NSRange range = [self rangeOfString:@"^\\s*" options:NSRegularExpressionSearch];
    NSString *result = [self stringByReplacingCharactersInRange:range withString:@""];
    
    range = [result rangeOfString:@"\\s*$" options:NSRegularExpressionSearch];
    result = [result stringByReplacingCharactersInRange:range withString:@""];
    
    NSString *temp;
    do {
        temp = result;
        result = [result stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    } while (![temp isEqualToString:result]);
    
    return result;
}

@end

@implementation CLCommonsMenuFetcher

#pragma mark - Public API

+ (CLCommonsMenu *)fetchMenuForCommons:(CLCommons)commons menuDay:(CLCommonsMenuDay)commonsMenuDay {
    
    NSString *commonsURL = [NSString stringWithFormat:@"http://speiseplan.studwerk.uptrade.de/de/%ld/2014/%ld/", commons, commonsMenuDay];
    NSData *menuData = [NSData dataWithContentsOfURL:[NSURL URLWithString:commonsURL]];
    NSString *menuHTMLString = [[NSString alloc] initWithData:menuData encoding:NSUTF8StringEncoding];
    
    NSError *error;
    HTMLParser *commonsMenuParser = [[HTMLParser alloc] initWithString:menuHTMLString error:&error];
    
    if (!commonsMenuParser) {
        NSLog(@"Error: %@", error);
    }
    
    NSArray *menuTableNodes = [[commonsMenuParser body] findChildTags:@"tr"];
    NSMutableArray *meals = [NSMutableArray new];
    NSString *menuDate;
    
    for (HTMLNode *rowElement in menuTableNodes) {
        if (!rowElement.className) {
            // headline
           menuDate = [[[rowElement findChildTag:@"th"] contents] stringByTrimmingWhitespaces];
        }
        else {
            // meal
            [meals addObject:[self createMealFromNode:rowElement]];
        }
    }
    
    return [[CLCommonsMenu alloc] initWithCommons:[self commonsToString:commons] date:menuDate meals:meals];
}

#pragma mark - Private helper methods

+ (CLCommonsMeal *)createMealFromNode:(HTMLNode *)node {
    NSString *mealCategory = [[[node findChildTag:@"th"] contents] stringByTrimmingWhitespaces];
    NSString *mealDescription;
    NSMutableArray *mealPrices = [NSMutableArray new];
    NSMutableArray *mealTags = [NSMutableArray new];
    NSArray *mealElements = [node findChildTags:@"td"];
    
    
    
    
    for (HTMLNode *mealElement in mealElements) {
        if ([mealElement.className isEqualToString:@"dish-description"]) {
            mealDescription = [self trimMealDescription:[mealElement allContents]];
        }
        else if ([mealElement.className isEqualToString:@"price"]) {
            [mealPrices addObject:[[mealElement contents] stringByTrimmingWhitespaces]];
        }
        
        NSArray *mealTagElements = [mealElement findChildTags:@"img"];
        for (HTMLNode *mealTag in mealTagElements) {
            [mealTags addObject:@([self tagURLToMealTag:[mealTag getAttributeNamed:@"src"]])];
        }
    }
    
    return [[CLCommonsMeal alloc] initWithDescription:mealDescription category:mealCategory prices:mealPrices tags:mealTags];
}

+ (NSString *)trimMealDescription:(NSString *)description {
    NSString *trimmedDescription = [description stringByReplacingOccurrencesOfString:@"(" withString:@""];
    trimmedDescription = [trimmedDescription stringByReplacingOccurrencesOfString:@")" withString:@""];
    trimmedDescription = [trimmedDescription stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    for (NSInteger i = 0; i < 10; i++) {
        trimmedDescription = [trimmedDescription stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%ld", i] withString:@""];
    }
    
    return [trimmedDescription stringByTrimmingWhitespaces];
}

+ (CLCommonsMealTag)tagURLToMealTag:(NSString *)tagURL {
    if ([tagURL isEqualToString:CLTagIMGAlcohol]) return CLCommonsMealTagAlcohol;
    if ([tagURL isEqualToString:CLTagIMGBeef]) return CLCommonsMealTagBeef;
    if ([tagURL isEqualToString:CLTagIMGCampusVital]) return CLCommonsMealTagCampusVital;
    if ([tagURL isEqualToString:CLTagIMGFish]) return CLCommonsMealTagFish;
    if ([tagURL isEqualToString:CLTagIMGLactoseFree]) return CLCommonsMealTagLactoseFree;
    if ([tagURL isEqualToString:CLTagIMGPork]) return CLCommonsMealTagPork;
    if ([tagURL isEqualToString:CLTagIMGPoultry]) return CLCommonsMealTagPoultry;
    if ([tagURL isEqualToString:CLTagIMGVegan]) return CLCommonsMealTagVegan;
    if ([tagURL isEqualToString:CLTagIMGVegetarian]) return CLCommonsMealTagVegetarian;

    return -1;
}

+ (NSString *)commonsToString:(CLCommons)commons {
    NSString *commonsName;
    
    switch (commons) {
        case CLCommonsArmgartstrasse:
            commonsName = @"Armgartstrasse";
            break;
        case CLCommonsBergedorf:
            commonsName = @"Bergedorf";
            break;
        case CLCommonsBerlinerTor:
            commonsName = @"Berliner Tor";
            break;
        case CLCommonsBotanischerGarten:
            commonsName = @"Botanischer Garten";
            break;
        case CLCommonsBuceriusLawSchool:
            commonsName = @"Bucerius Law School";
            break;
        case CLCommonsCafeAverhoffstrasse:
            commonsName = @"Cafe Averhoffstrasse";
            break;
        case CLCommonsCafeCFEL:
            commonsName = @"Cafe CFEL";
            break;
        case CLCommonsCafeJungiusstrasse:
            commonsName = @"Cafe Jungiusstrasse";
            break;
        case CLCommonsCafeAlexanderstrasse:
            commonsName = @"Cafe Alexanderstrasse";
            break;
        case CLCommonsCampus:
            commonsName = @"Campus";
            break;
        case CLCommonsCityNord:
            commonsName = @"City Nord";
            break;
        case CLCommonsFinkenau:
            commonsName = @"Finkenau";
            break;
        case CLCommonsGeomatikum:
            commonsName = @"Geomatikum";
            break;
        case CLCommonsHarburg:
            commonsName = @"Harburg";
            break;
        case CLCommonsPhilosophenturm:
            commonsName = @"Philosophenturm";
            break;
        case CLCommonsStellingen:
            commonsName = @"Stellingen";
            break;
        case CLCommonsStudierendenhaus:
            commonsName = @"Studierendenhaus";
            break;
        case CLCommonsHCU:
            commonsName = @"Mensa HCU";
            break;
        default:
            commonsName = @"Error occurred";
            break;
    }
    
    return commonsName;
}

@end