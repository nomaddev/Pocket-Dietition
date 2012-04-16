//
//  NutrientWarningCalculator.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 3/6/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NutrientWarningCalculator.h"

#import "UserDailyLimits.h"
#import "NutrientAmount.h"
#import "WarningState.h"
#import "Constants.h"
#import "Meal.h"
#import "UserConsumedNutrientLevelsAndLimits.h"

@implementation NutrientWarningCalculator

+ (int) numberOfViolationsForUserConsumedNutrientLevelsAndLimits:(UserConsumedNutrientLevelsAndLimits *) consumedLevelsAndLimits forMeal:(Meal *)plannedMeal
{
    int numWarnings = 0;
    for (NSString *nutNo in [consumedLevelsAndLimits trackedNutrientNumbers])
    {
        int consumedPercent = [consumedLevelsAndLimits nutrientConsumedAmountForNutrientNumber:nutNo].quantity;
        int total = [[consumedLevelsAndLimits dailyLimits] nutrientAmountForNutrientNumber:nutNo].quantity;             
        
        //TODO: something's wrong here - we're getting 0's for a lot of the nutrients
        int plannedPercent = [plannedMeal nutrientAmountForNutrientNumber:nutNo].quantity / total;
        
        WarningState *warning = [self warningStateForNutrientNo:nutNo andPlannedLevel:plannedPercent andConsumedLevel:consumedPercent];
        
        NSLog(@"nut %@ warning severity: %d", nutNo, warning.warningSeverity);
        
        if (warning.warningSeverity!=kNO_WARNING)
            numWarnings++;
    }
    return numWarnings;
}

+(float) allowedPercentageForMeal:(MealType) mealType andNutrientNo:(NSString *) nutrientNo
{
    if (mealType==NOT_SET) return 100; //when just starting app, or resetting meal
    
    //    sodium 307
    //    potassium 306
    //    phosphorus 305
    //    protein 203
    //    (adjusted protein 257)
    //    fluids 255
    //    calories 208
    //    carbohydrates 205
    //    fat 204
    //    
    //    
    //    fiber 291
    
    //    Electrolyte/Macronutrient    Breakfast  Lunch   Dinner  Snack
    //    Sodium Maximum                  33%      45%     45%     45%
    
    //    Potassium Maximum               50%      80%     80%     80%
    //    Phosphorus Maximum              50%      80%     80%     80%
    //    Carbohydrate Maximum            50%      80%     80%     80%
    //    Protein Maximum                 50%      80%     80%     80%
    //    Fat Maximum                     50%      80%     80%     80%
    
    
    
    
    if ([nutrientNo isEqualToString:kSODIUM])
    {
        //    Electrolyte/Macronutrient    Breakfast  Lunch   Dinner  Snack
        //    Sodium Maximum                  33%      45%     45%     45%
        float mealAllowedPercents[4]  =  {0.33, 0.45, 0.45, 0.45};
        return mealAllowedPercents[mealType];
    }
    else 
        
    {
        //    Electrolyte/Macronutrient    Breakfast  Lunch   Dinner  Snack
        //    all others                      50%      80%     80%     80%
        float mealAllowedPercents[4]  =  {0.5, 0.8, 0.8, 0.8};
        return mealAllowedPercents[mealType];
    }   
    
    
}


+ (WarningState *)warningStateForNutrientNo:(NSString *) nutrientNo andPlannedLevel:(float) plannedLevelPercent andConsumedLevel:(float) consumedLevelPercent
{
    float totalProgress = plannedLevelPercent + consumedLevelPercent;
    
    
    WarningState *warningStateForDailyLimit = [[WarningState alloc] init];
    WarningState *warningStateForMealLimit = [[WarningState alloc] init];
    
    if (plannedLevelPercent==0)
        return warningStateForMealLimit; //no warnings if not plannng meal
    
    //color transparent section if about to go over daily total thresholds
    if (totalProgress >= kRED_THRESHOLD)
    {
        NSLog(@">day");
        warningStateForDailyLimit.violatedLimitType = kDAILY;
        warningStateForDailyLimit.warningSeverity = kRED_WARNING;
    }
    else if (totalProgress >= kYELLOW_THRESHOLD)
    {
        NSLog(@">day");
        warningStateForDailyLimit.violatedLimitType = kDAILY;
        warningStateForDailyLimit.warningSeverity = kYELLOW_WARNING;
    }
    else
    {
        warningStateForDailyLimit.warningSeverity = kNO_WARNING;
    }
    
    //now check meal/nutrient max allowed percentages
    
    float maxMealAmountAsPercentOfTotal = [self allowedPercentageForMeal:[Meal sharedInstance].mealType andNutrientNo:nutrientNo];
    
    
    //color transparent section if about to go over meal "% of total allowed" thresholds
    if (plannedLevelPercent >= maxMealAmountAsPercentOfTotal * kRED_THRESHOLD)
    {
        NSLog(@">meal");
        warningStateForMealLimit.violatedLimitType = kMEAL;
        warningStateForMealLimit.warningSeverity = kRED_WARNING;
    }
    else if (plannedLevelPercent >= maxMealAmountAsPercentOfTotal * kYELLOW_THRESHOLD)
    {
        NSLog(@">meal");
        warningStateForMealLimit.violatedLimitType = kMEAL;
        warningStateForMealLimit.warningSeverity = kYELLOW_WARNING;
    }
    else
    {
        warningStateForDailyLimit.warningSeverity = kNO_WARNING;
    }
    
    WarningState *mostSevereWarningState = nil;
    
    if (warningStateForMealLimit.warningSeverity > warningStateForDailyLimit.warningSeverity)
    {
        mostSevereWarningState = warningStateForMealLimit;
    }
    else 
    {
        mostSevereWarningState = warningStateForDailyLimit;
    }
    return mostSevereWarningState;
}



@end
