//
//  Meal.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/8/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

/* singleton boilerplate when using ARC based off of :
 * http://iphone.galloway.me.uk/iphone-sdktutorials/singleton-classes/
 */

#import "Meal.h"
#import "NutrientAmount.h"
#import "MealPortion.h"

#import "NFNNumber.h"

#import "Food.h"

static Meal *sharedInstance = nil;
@implementation Meal

@synthesize mealType;
NSString * const NOTIFICATION_MEAL_TYPE_CHANGE = @"meal_type_change";
NSString * const NOTIFICATION_MEAL_MEAL_PORTION_CHANGE = @"meal_type_meal_portion_change";

#pragma mark Singleton Methods
+ (id)sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

+(NSString *) prefKeyForTodaysLastMeal
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:now];
    return [NSString stringWithFormat:@"lastMeal%@", dateString];
}

+(void) rememberLastMeal:(MealType) newMeal
{
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setInteger:newMeal forKey:[Meal prefKeyForTodaysLastMeal]];
    
    [defaults synchronize];
}
+(MealType) nextMealType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (nil == [defaults objectForKey:[Meal prefKeyForTodaysLastMeal]])
        return BREAKFAST;
    
    MealType lastMeal = [defaults integerForKey:[Meal prefKeyForTodaysLastMeal]];
    
    if (lastMeal==SNACK)
    {
        return SNACK;
    }
    else 
    {
        return lastMeal + 1;
    }
}



+ (NSString *) nameForMealType: (MealType) type
{
    switch (type) 
    {
        case BREAKFAST:
            return @"Breakfast";
            break;
        case LUNCH:
            return @"Lunch";
            break;
        case DINNER:
            return @"Dinner";
            break;
        case SNACK:
            return @"Snack";
            break;
        default:
            return nil;
    }
}

- (id)init 
{
    if (self = [super init]) 
    {
        mealPortionArray = [NSMutableArray arrayWithCapacity:3];
        mealType = NOT_SET;
    }
    return self;
}

- (void) setMealType: (MealType) parameterMealType{
    mealType = parameterMealType;
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_MEAL_TYPE_CHANGE object: nil];
}


/*
-(MealType) mealType{
    return mealType;
}
*/

-(void) addMealPortion:(MealPortion *)foodPortion{
    if(!foodPortion) return;
    // update notification
    
    // don't save it again if we already have it
    if( ![mealPortionArray containsObject:foodPortion] ) {
        [mealPortionArray addObject:foodPortion];
    }
    
    // fire notification for the add/attempted add
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_MEAL_MEAL_PORTION_CHANGE object: nil];

}

-(void) removeMealPortionAtIndex: (NSUInteger) index{
    if( index >= [mealPortionArray count] ) return;
    
    [mealPortionArray removeObjectAtIndex:index];
    // update notification
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_MEAL_MEAL_PORTION_CHANGE object: nil];
}

-(void) removeMealPortion: (MealPortion *) mealPortion{
    if(!mealPortion) return;
    
    if( [mealPortionArray containsObject:mealPortion] ) {
        [mealPortionArray removeObject:mealPortion];
    }
    // update notification
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_MEAL_MEAL_PORTION_CHANGE object: nil];
}

-(void) replaceMealPortion:(MealPortion *) originalMealPortion with:(MealPortion *)newMealPortion
{
    NSLog(@"replaceMealPortion: newMealPortion.quantity = %f", [newMealPortion.quantity valueAsFloat]);
    if(!originalMealPortion) return;
    if(!newMealPortion) return;
    if(![mealPortionArray containsObject:originalMealPortion]) return;
    
    NSUInteger index = [mealPortionArray indexOfObject:originalMealPortion];
    NSLog(@"index: %d", index);
    [mealPortionArray replaceObjectAtIndex:index withObject:newMealPortion];
    
    NSLog(@"replaceMealPortion DONE: mealPortionArray[index].quantity = %f", [((MealPortion *)[mealPortionArray objectAtIndex:index]).quantity valueAsFloat]);
    
    // update notification
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_MEAL_MEAL_PORTION_CHANGE object: nil];
}

-(MealPortion *) mealPortionAtIndex: (NSUInteger) index{
    if( index >= [mealPortionArray count] ) return nil;
    
    return [mealPortionArray objectAtIndex:index];
}

-(void) reset{
    // empty out the object and return to a blank state
    [mealPortionArray removeAllObjects];
    
    // reset the meal type to not_set
    self.mealType = NOT_SET;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_MEAL_MEAL_PORTION_CHANGE object: nil];
}

-(NSUInteger) numberOfMealPortions{
    return [mealPortionArray count];
}

-(NutrientAmount *) nutrientAmountForNutrientNumber:(NSString *) parameterNutrientNumber{
    NutrientAmount *totalNutrientInfo = [[NutrientAmount alloc]init];
    for(MealPortion *portion in mealPortionArray)
    {
        NSLog(@"portion: %@ = %f", portion.food.descriptionLong, totalNutrientInfo.quantity);
        NutrientAmount *info = [portion nutrientInfoForNutrientNumber:parameterNutrientNumber];
        totalNutrientInfo.quantity += info.quantity;
        totalNutrientInfo.unit = info.unit;
    }
    return totalNutrientInfo;
}

@end
