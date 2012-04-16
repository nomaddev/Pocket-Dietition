//
//  NSObject+NutrientDataHelper.h
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 3/1/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Nutrient;
@class DailyNutrientLevels;
@class UserDailyLimits;

@interface NSObject (NutrientDataHelper)

-(Nutrient *) findNutrientWithNutrientNumber:(NSString *) inNutrientNumber usingManagedContext:(NSManagedObjectContext *) inContext;
-(DailyNutrientLevels *) findDailyNutrientLevelsFor:(NSDate *) inDate usingManagedContext:(NSManagedObjectContext *) inContext;
-(DailyNutrientLevels *) createDailyNutrientLevelsFor:(NSDate *) inDate withLimits:(UserDailyLimits *)inLimits usingManagedContext:(NSManagedObjectContext *) inContext;
@end
