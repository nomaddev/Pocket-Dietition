//
//  UsersDiet.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/18/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "UserDailyLimits.h"
#import "AppDelegate.h"
#import "Nutrient.h"
#import "NutrientAmount.h"
#import "DefaultDietBuilder.h"

@implementation UserDailyLimits
@synthesize date;

- (id)init {
    self = [super init];
    if (self) {
        userNutrientAmounts = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NutrientAmount *) nutrientAmountForNutrientNumber:(NSString *)parameterNutrientNumber{
    return [userNutrientAmounts valueForKey:parameterNutrientNumber];
}

- (NSArray *) trackedNutrientNumbers{
    return [userNutrientAmounts  allKeys];
}

/*
 * Adds or replaces NutrientAmount for nutrient number.
 */
- (void) addNutrientAmount:(NutrientAmount *) parameterNutrientAmount forNutrientNumber:(NSString *) parameterNutrientNumber{
    if(!parameterNutrientNumber || !parameterNutrientAmount) return;
            
    [userNutrientAmounts setValue:parameterNutrientAmount forKey:parameterNutrientNumber];
        
}

- (void) removeNutrientAmountForNutrientNumber:(NSString *)parameterNutrientNumber{
    [userNutrientAmounts removeObjectForKey:parameterNutrientNumber];
}

- (void) clear{
    [userNutrientAmounts removeAllObjects];
}

    
@end
