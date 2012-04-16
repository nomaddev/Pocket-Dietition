//
//  NutrientWarningCalculator.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 3/6/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WarningState;
@class UserConsumedNutrientLevelsAndLimits;

@class Meal;

@interface NutrientWarningCalculator : NSObject

+ (WarningState *)warningStateForNutrientNo:(NSString *) nutrientNo andPlannedLevel:(float) plannedLevelPercent andConsumedLevel:(float) consumedLevelPercent;

+ (int) numberOfViolationsForUserConsumedNutrientLevelsAndLimits:(UserConsumedNutrientLevelsAndLimits *) consumedLevelsAndLimits forMeal:(Meal *)plannedMeal;
//+ (int) numberOfViolationsForUserConsumedNutrientLevelsAndLimits:(UserConsumedNutrientLevelsAndLimits *) consumedLevelsAndLimits withPlannedLevels:()

@end

