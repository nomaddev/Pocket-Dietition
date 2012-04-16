//
//  DefaultDietBuilder.h
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/21/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserDailyLimits;

@interface DefaultDietBuilder : NSObject

+ (void) defaultDiabeticDietForUserDailyLimit:(UserDailyLimits **) parameterUserDiet;
+ (void) defaultHypertensionDietForUserDailyLimit:(UserDailyLimits **) parameterUserDiet;



@end
