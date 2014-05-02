//
//  CLCommonsMenu.h
//  CommonsMenu
//
//  Created by Jan Hennings on 12/22/13.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLCommonsMeal.h"

@interface CLCommonsMenu : NSObject

#pragma mark - Readonly API

// Name of the commons
@property (nonatomic, readonly) NSString *commons;

// Textformat of the date
@property (nonatomic ,readonly) NSString *date;

// Array of CLCommonsMeal objects
@property (nonatomic, readonly) NSArray *meals;

#pragma mark - Helper methods

// Logs the data of the menu in the console
- (void)logMenu;


-(CLCommonsMenu *) filteredMenuUsingTags: (NSArray *) tags;

#pragma mark - Initializers

- (instancetype)initWithCommons:(NSString *)aCommons date:(NSString *)aDate meals:(NSArray *)mealsArray;

@end