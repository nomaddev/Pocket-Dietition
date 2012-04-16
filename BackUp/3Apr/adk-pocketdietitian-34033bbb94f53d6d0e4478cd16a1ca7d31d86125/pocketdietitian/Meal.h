//
//  Meal.h
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/8/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//
/*
 * Shared singleton that keeps track of foods comprising a meal
 */

#import <Foundation/Foundation.h>
@class MealPortion;
@class NutrientAmount;

@interface Meal : NSObject{
    NSMutableArray* mealPortionArray;
}

typedef enum mealTypeEnum{ BREAKFAST, LUNCH, DINNER, SNACK, BRUNCH, TACO_BELL_FOURTH_MEAL, NOT_SET } MealType ;
extern NSString * const NOTIFICATION_MEAL_TYPE_CHANGE;
extern NSString * const NOTIFICATION_MEAL_MEAL_PORTION_CHANGE;

@property (nonatomic) MealType mealType;

+(MealType) nextMealType;
+(void) rememberLastMeal:(MealType) newMeal;
-(void) addMealPortion:(MealPortion *)foodPortion;
-(void) removeMealPortionAtIndex: (NSUInteger) index;
-(MealPortion *) mealPortionAtIndex: (NSUInteger) index;
-(void) reset;
-(NSUInteger) numberOfMealPortions;
-(NutrientAmount *) nutrientAmountForNutrientNumber:(NSString *) parameterNutrientNumber;
-(void) replaceMealPortion:(MealPortion *) originalMealPortion with:(MealPortion *)newMealPortion;
-(void) removeMealPortion: (MealPortion *) mealPortion;

+(Meal *) sharedInstance;
+ (NSString *) nameForMealType: (MealType) type;

@end
