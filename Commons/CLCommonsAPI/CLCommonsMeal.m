//
//  CLCommonsMeal.m
//  CommonsMenu
//
//  Created by Jan Hennings on 12/21/13.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "CLCommonsMeal.h"

@implementation CLCommonsMeal

#pragma mark - Initializers

- (instancetype)initWithDescription:(NSString *)aDescription category:(NSString *)aCategory prices:(NSArray *)pricesArray tags:(NSArray *)tagsArray;{
    self = [super init];
    
    if (self) {
        _description = aDescription;
        _category = aCategory;
        _prices = pricesArray;
        _tags = tagsArray;
    }
    
    return self;
}

@end