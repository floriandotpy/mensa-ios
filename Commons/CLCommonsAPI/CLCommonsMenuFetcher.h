//
//  CLCommonsMenuFetcher.h
//  CommonsMenu
//
//  Created by Jan Hennings on 12/22/13.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLCommonsMenu.h"

#pragma mark - CLCommons enums

typedef NS_ENUM(NSInteger, CLCommons) {
    CLCommonsArmgartstrasse = 590,
    CLCommonsBergedorf = 520,
    CLCommonsBerlinerTor = 530,
    CLCommonsBotanischerGarten = 560,
    CLCommonsBuceriusLawSchool = 410,
    CLCommonsCafeAverhoffstrasse = 650,
    CLCommonsCafeCFEL = 680,
    CLCommonsCafeJungiusstrasse = 610,
    CLCommonsCafeAlexanderstrasse = 660,
    CLCommonsCampus = 340,
    CLCommonsCityNord = 550,
    CLCommonsFinkenau = 620,
    CLCommonsGeomatikum = 540,
    CLCommonsHarburg = 570,
    CLCommonsPhilosophenturm = 350,
    CLCommonsStellingen = 580,
    CLCommonsStudierendenhaus = 310,
    CLCommonsHCU = 430
};

typedef NS_ENUM(NSInteger, CLCommonsMenuDay) {
    CLCommonsMenuDayCurrent = 0,
    CLCommonsMenuDayNext = 99
};

@interface CLCommonsMenuFetcher : NSObject

#pragma mark - Public API

// Fetch current menu for commons at given menuDay
+ (CLCommonsMenu *)fetchMenuForCommons:(CLCommons)commons menuDay:(CLCommonsMenuDay)commonsMenuDay;

@end