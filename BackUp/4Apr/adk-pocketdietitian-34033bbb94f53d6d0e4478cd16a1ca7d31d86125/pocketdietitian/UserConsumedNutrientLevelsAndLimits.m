//
//  UserNutritionLevels.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/24/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UserConsumedNutrientLevelsAndLimits.h"

#import "NutrientAmount.h"
#import "UserDailyLimits.h"
//From the DB
#import "DailyNutrientLevels.h"
#import "NutrientLevel.h"

@implementation UserConsumedNutrientLevelsAndLimits
@synthesize dailyLimits;

- (NutrientAmount *) _createNewConsumedNutrientEntry:(NSString *)inNutrientNumber {
    NutrientAmount *amount;
    amount = [self.dailyLimits nutrientAmountForNutrientNumber:inNutrientNumber];
    // If the nutrient isnt in the limits, its not being tracked, return the nil
    if(!amount) return amount;
    
    // clone and save the nutrient and empty out its value
    amount = [amount copy];
    amount.quantity = 0;
    [nutrientConsumedAmountDictionary setObject:amount forKey:inNutrientNumber];
    
    // use the value in the daily limits for this nutrient
    NSPredicate *nutrientPredicate = [NSPredicate predicateWithFormat:@"nutrient.nutrientNo = %@", inNutrientNumber];
    NSSet *filteredNutrientLevels = [[dailyNutrientLevels nutrientLevels] filteredSetUsingPredicate:nutrientPredicate];
    if(filteredNutrientLevels && [filteredNutrientLevels count] > 0){
        NutrientLevel *currentSavedNutrientLevel = [[filteredNutrientLevels objectEnumerator] nextObject];
        amount.quantity = [currentSavedNutrientLevel.consumed floatValue];
    }
    
    return amount;
}

- (NutrientAmount *)nutrientConsumedAmountForNutrientNumber:(NSString *)inNutrientNumber
{
    return [nutrientConsumedAmountDictionary objectForKey:inNutrientNumber];
}

- (NSArray *) trackedNutrientNumbers
{
    return [self.dailyLimits trackedNutrientNumbers];
}



- (id)initWithDailyLevels:(DailyNutrientLevels *)inDailyLevels dailyLimits:(UserDailyLimits *)inDailyLimits managedContext:(NSManagedObjectContext *)inContext
{    
    self = [super init];
    
    if(self)
    {
        nutrientConsumedAmountDictionary = [NSMutableDictionary dictionary];
        self.dailyLimits = inDailyLimits;
        dailyNutrientLevels = inDailyLevels;
        managedObjectContext = inContext;
        //create an entry for each tracked nutrient (pull from db for today, if already there)
        for (NSString *trackedNutrientNo in [self.dailyLimits trackedNutrientNumbers]) 
        {
            [self _createNewConsumedNutrientEntry:trackedNutrientNo];
        }
    }
    
    return self;
}

//-(void) setDailyLimits:(UserDailyLimits *)inDailyLimits{
//    dailyLimits = inDailyLimits;
//    // clear out all the nutrition amounts
//    [self reset];
//}

//-(void)reset{
//    [nutrientAmountDictionary removeAllObjects];
//}

-(NutrientLevel *) nutrientLevelForNutrientNumber:(NSString *)inNutrientNumber{
    // use the value in the daily limits for this nutrient
    NSPredicate *nutrientPredicate = [NSPredicate predicateWithFormat:@"nutrient.nutrientNo = %@", inNutrientNumber];
    NSSet *filteredNutrientLevels = [[dailyNutrientLevels nutrientLevels] filteredSetUsingPredicate:nutrientPredicate];
    if(!filteredNutrientLevels && [filteredNutrientLevels count] < 1) return nil;
    
    return [[filteredNutrientLevels objectEnumerator] nextObject];
    
}

-(void)addNutrientAmount:(NutrientAmount *)inNutrientAmount toNutrientNumber:(NSString *)inNutrientNumber{
    if(!inNutrientNumber || !inNutrientAmount) return;
    
    NutrientAmount *trackedNutrient = [nutrientConsumedAmountDictionary objectForKey:inNutrientNumber];
    
    // make sure we're tracking the nutrient
    if(!trackedNutrient) return;
    
    // make sure the units are the same
    if(![inNutrientAmount.unit isEqualToString:trackedNutrient.unit]) return;
    
    // add the new to the old
    trackedNutrient.quantity += inNutrientAmount.quantity;
    
    // add the new value to the persisted values
    NutrientLevel *nutrientLevel = [self nutrientLevelForNutrientNumber:inNutrientNumber];
    nutrientLevel.consumed = [NSNumber numberWithFloat:trackedNutrient.quantity];
    
    // persist into core data
    NSError *error = nil;
    [managedObjectContext save:&error];
    if(error){
        NSLog(@"There was an error saving the new nutrient amount: %@", error.description);
    }
}
@end
