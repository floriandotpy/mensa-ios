//
//  CommonsTests.m
//  CommonsTests
//
//  Created by Jan Hennings on 1/27/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLCommonsMenuFetcher.h"

@interface CommonsTests : XCTestCase

@end

@implementation CommonsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFetchedDataNotNil {
    NSArray *commons = @[@(CLCommonsArmgartstrasse),
                         @(CLCommonsBergedorf),
                         @(CLCommonsBerlinerTor),
                         @(CLCommonsBotanischerGarten),
                         @(CLCommonsBuceriusLawSchool),
                         @(CLCommonsCafeAverhoffstrasse),
                         @(CLCommonsCafeCFEL),
                         @(CLCommonsCafeJungiusstrasse),
                         @(CLCommonsCafeAlexanderstrasse),
                         @(CLCommonsCampus),
                         @(CLCommonsCityNord),
                         @(CLCommonsFinkenau),
                         @(CLCommonsGeomatikum),
                         @(CLCommonsHarburg),
                         @(CLCommonsPhilosophenturm),
                         @(CLCommonsStellingen),
                         @(CLCommonsStudierendenhaus)];
    
    for (int i = 0; i < commons.count; i++) {
        CLCommonsMenu *menu = [CLCommonsMenuFetcher fetchMenuForCommons:(CLCommons)[commons[i] integerValue] menuDay:CLCommonsMenuDayCurrent];
        //NSString *error = [NSString stringWithFormat:@"%@"]
        XCTAssertNotNil(menu.date);
        XCTAssertNotNil(menu.commons);
        XCTAssertNotNil(menu.meals);
        
        for (CLCommonsMeal *meal in menu.meals) {
            XCTAssertNotNil(meal.description);
            XCTAssertNotNil(meal.category);
            XCTAssertNotNil(meal.prices);
            
            for (NSString *price in meal.prices) {
                XCTAssertNotNil(price);
            }
        }
    }
}


@end
