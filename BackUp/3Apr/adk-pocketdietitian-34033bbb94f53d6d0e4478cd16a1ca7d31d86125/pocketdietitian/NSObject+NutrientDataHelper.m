//
//  NSObject+NutrientDataHelper.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 3/1/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NSObject+NutrientDataHelper.h"
#import "Nutrient.h"
#import "DailyNutrientLevels.h"
#import "NSDate+NSDateAdditions.h"
#import "UserDailyLimits.h"
#import "NutrientLevel.h"
#import "NutrientAmount.h"

@implementation NSObject (NutrientDataHelper)


-(Nutrient *) findNutrientWithNutrientNumber:(NSString *) inNutrientNumber usingManagedContext:(NSManagedObjectContext *) inContext{
    NSManagedObjectContext *context = inContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *nutrientEntity = [NSEntityDescription entityForName:[Nutrient entityName]
                                                      inManagedObjectContext:context];
    [fetchRequest setEntity:nutrientEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nutrientNo = %@",
                              inNutrientNumber];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        return nil;
    }
    
    return [fetchedObjects objectAtIndex:0];
}

-(DailyNutrientLevels *) findDailyNutrientLevelsFor:(NSDate *) inDate usingManagedContext:(NSManagedObjectContext *) inContext{
    NSManagedObjectContext *context = inContext;
    
    // find the DailyNutrientLevels for the day in NSDate
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *dailyLevelsEntity = [NSEntityDescription entityForName:[DailyNutrientLevels entityName] inManagedObjectContext:context];
    [fetchRequest setEntity:dailyLevelsEntity];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterLongStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    // start of the day
    NSDate *startofDay = [inDate startOfDay];
    NSLog(@"start of day is: %@", [dateFormatter stringFromDate:startofDay]);
    // end of the day
    NSDate *endOfDay = [inDate endOfDay];
    NSLog(@"end of day is: %@", [dateFormatter stringFromDate:endOfDay]);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"((date > %@) AND (date <= %@))", startofDay, endOfDay ];
    //[NSPredicate predicateWithFormat:@"date BETWEEN %@ ", [NSArray arrayWithObjects:startofDay, endOfDay, nil] ];
    [fetchRequest setPredicate:predicate];
    
    NSLog(@"entity: %@", [DailyNutrientLevels entityName]);
    NSLog(@"entity descr: %@", dailyLevelsEntity.name);
    NSLog(@"rqst entity: %@", fetchRequest.entity.name);
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil || [fetchedObjects count]< 1) return nil;
    
    return [fetchedObjects objectAtIndex:[fetchedObjects count]-1];
}

-(DailyNutrientLevels *) createDailyNutrientLevelsFor:(NSDate *) inDate withLimits:(UserDailyLimits *)inLimits usingManagedContext:(NSManagedObjectContext *) inContext{
    
    NSManagedObjectContext *context = inContext;
    
    DailyNutrientLevels *dailyLevels = [NSEntityDescription
                                        insertNewObjectForEntityForName:[DailyNutrientLevels entityName] 
                                        inManagedObjectContext:context];
    dailyLevels.date = inDate;
    
    //add the nutrients
    for(NSString *nutrientNumber in [inLimits trackedNutrientNumbers]){
        @autoreleasepool {
            NutrientAmount *nutrientAmount = [inLimits nutrientAmountForNutrientNumber:nutrientNumber];
            NutrientLevel *nutrientLevel = [NSEntityDescription
                                            insertNewObjectForEntityForName:[NutrientLevel entityName] 
                                            inManagedObjectContext:context];
            nutrientLevel.consumed = 0;
            nutrientLevel.allowed = [NSNumber numberWithFloat:nutrientAmount.quantity];
            nutrientLevel.nutrient = [self findNutrientWithNutrientNumber:nutrientNumber usingManagedContext:inContext];
            
            [dailyLevels addNutrientLevelsObject:nutrientLevel];
            
        }
        
    }
   
    // persist the daily levels
    NSError *error = nil;
    [context save:&error];
    
    if(error){
        NSLog(@"Saving DailyNutrienLevels failed: %@", error.description);
    }
    return dailyLevels;
}


@end
