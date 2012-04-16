//
//  NutrientLevelDataModelTest.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/27/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NutrientLevelDataModelTest.h"
#import "NutrientLevel.h"
#import "Nutrient.h"
#import "DailyNutrientLevels.h"

@implementation NutrientLevelDataModelTest

-(Nutrient *) findNutrientWithNutrientNumber:(NSString *) inNutrientNumber{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *nutrientEntity = [NSEntityDescription entityForName:[Nutrient entityName]
                                                      inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:nutrientEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nutrientNo = %@",
                              inNutrientNumber];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        GHTestLog(@"failed to find a nutrient. %@", error.domain);
        return nil;
    }

    return [fetchedObjects objectAtIndex:0];
}


-(void) testNutrientLevelSave{
    NSManagedObjectContext *context = self.managedObjectContext;
            
    Nutrient *nutrient =[self findNutrientWithNutrientNumber:@"307"]; //lookup sodium
    GHAssertNotNil(nutrient, @"Failed to find nutrient");
    
    // create the nutrient level we will use to test with
    NutrientLevel *nutrientLevel = [NSEntityDescription
     insertNewObjectForEntityForName:[NutrientLevel entityName] 
     inManagedObjectContext:context];
    
    nutrientLevel.consumed = [NSNumber numberWithFloat:5.5];
    nutrientLevel.allowed = [NSNumber numberWithFloat:6];
    nutrientLevel.nutrient = nutrient;
    
    NSError *error = [[NSError alloc]init];
    [context save:&error ];
    
    // retrieve the nutrient level we just saved
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *nutrientLevelEntity = [NSEntityDescription entityForName:[NutrientLevel entityName] inManagedObjectContext:context];
    [fetchRequest setEntity:nutrientLevelEntity];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nutrient.nutrientNo = %@",
    @"307"];
    [fetchRequest setPredicate:predicate];

    error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    GHAssertNotNil ( fetchedObjects, @"No nutrient level found. %@", error.domain);
    
    NutrientLevel *retrievedNutrientLevel = [fetchedObjects objectAtIndex:[fetchedObjects count]-1];
    GHAssertEquals([retrievedNutrientLevel.consumed floatValue] , [nutrientLevel.consumed floatValue], @"Failed to retrieve saved nutrient level");
    
}


-(void) testDailyNutrientLevelsSave{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    //Nutrient level to save
    NutrientLevel *nutrientLevel = [NSEntityDescription
                                    insertNewObjectForEntityForName:[NutrientLevel entityName] 
                                    inManagedObjectContext:context];
    
    Nutrient *nutrient =[self findNutrientWithNutrientNumber:@"307"]; //lookup sodium
    nutrientLevel.consumed = [NSNumber numberWithFloat:4.4];
    nutrientLevel.allowed = [NSNumber numberWithFloat:5];
    nutrientLevel.nutrient = nutrient;
    
    // save the nutrient
    [context save:nil];
    
    // Daily nutrient to save
    DailyNutrientLevels *dailyLevels = [NSEntityDescription
                                        insertNewObjectForEntityForName:[DailyNutrientLevels entityName] 
                                        inManagedObjectContext:context];
    
    // associate the nutrientlevel to the daily level
    [dailyLevels addNutrientLevelsObject:nutrientLevel];
    
    GHAssertGreaterThan( [dailyLevels.nutrientLevels count] ,(NSUInteger) 0, @"Failed to associate nutrient level with daily levels: %d", [dailyLevels.nutrientLevels count]);
    
    dailyLevels.date = [NSDate date];
    
    // save the dailies
    [context save:nil];
    
    //confirm we saved 
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *retrievedDailyLevels = [NSEntityDescription entityForName:[DailyNutrientLevels entityName]
    inManagedObjectContext:context];
    [fetchRequest setEntity:retrievedDailyLevels];

    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    GHAssertNotNil ( fetchedObjects, @"No daily levels found %@", error.domain);
    DailyNutrientLevels *retrievedLevels = [fetchedObjects objectAtIndex:[fetchedObjects count]-1];
    GHAssertTrue([retrievedLevels.date isEqualToDate:dailyLevels.date], @"DailyLevels were not saved %@ != %@", [retrievedLevels description], [dailyLevels description]);
    GHAssertTrue( [retrievedLevels.nutrientLevels count] == [dailyLevels.nutrientLevels count], @"Daily Levels were not saved. Saved Nutrient level do not match");
}

@end
