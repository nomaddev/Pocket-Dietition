//
//  USDADatabaseImporterTest.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/27/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NFNBaseCoreDataTestCase.h"
#import "USDADatabaseImporter.h"
#import "Nutrient.h"
#import "FoodNutrientData.h"
#import "Food.h"
#import "FoodGroup.h"
#import "FoodUnitWeight.h"

@interface USDADatabaseImporterTest : NFNBaseCoreDataTestCase

-(void) recreateAndImportDatabase;
@end

@implementation USDADatabaseImporterTest
{
    bool skipImport;
}


-(void) setUp
{
    [super setUp]; //this will copy over the db file from Supporting Files
    
    //comment this out if you want to test the actual import (from the USDA text files)
    skipImport = TRUE; 
    
    if(!skipImport) 
    {
        [self recreateAndImportDatabase];
        skipImport = TRUE; //don't import before each test, once per test suite is enough
    }
}


-(void)recreateAndImportDatabase{ 
    
    GHTestLog(@"Removing existing database.");
    //remove the existing db so we can create a fresh one for the test
    [USDADatabaseImporter removePersistentStoreAtUrl:[self getStoreURL]];
    
    self.managedObjectContext = nil;
    self.managedObjectModel = nil;
    self.persistentStoreCoordinator = nil;
    
    GHTestLog(@"Performing first time import of database.");
    [USDADatabaseImporter importDatabase:[self managedObjectContext]];
}

-(void) testNutrientsExist
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[Nutrient entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    NSLog(@"nutrient count after save: %d", [items count]);
    
    GHAssertGreaterThan([items count], (uint)0, @"there were no nutrients post import");

}

-(void) testNutrientDataExist
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[FoodNutrientData entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    NSLog(@"nut data count after save: %d", [items count]);
    
    GHAssertGreaterThan([items count], (uint)0, @"there were no nutrient data post import");
}

-(void) testNutrientDataToNutrientRelationships
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[FoodNutrientData entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];

    for (FoodNutrientData * nData in items) 
    {        
        GHAssertNotNil(nData.nutrient, @"found nutrient data with no nutrient relationship");
    }
}

// Food Group tests
-(void) testGroupsExist
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[FoodGroup entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    NSLog(@"nutrient count after save: %d", [items count]);
    
    GHAssertGreaterThan([items count], (uint)0, @"there were no nutrients post import");
    
}

-(void) testFoodGroupHasFoods{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[FoodGroup entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    for (FoodGroup * group in items) 
    {        
        GHAssertGreaterThan([group.foods count], (uint)0,  @"found food group with no foods");
    }
}

// Unit Weight tests
-(void) testUnitWeightsExist
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[FoodUnitWeight entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    NSLog(@"nutrient count after save: %d", [items count]);
    
    GHAssertGreaterThan([items count], (uint)0, @"there were no nutrients post import");
    
}

// Food Tests
-(void) testFoodsExist
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[Food entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    NSLog(@"nutrient count after save: %d", [items count]);
    
    GHAssertGreaterThan([items count], (uint)0, @"there were no nutrients post import");
    
}

-(void) testFoodHasNutrientData
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[Food entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    for (Food * food in items) 
    {        
        GHAssertGreaterThan([food.nutrients count], (uint)0,  @"found food with no nutrient data relationship  %@", food.ndbNo);
    }
}

-(void) testFoodHasUnitWeights
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[Food entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    for (Food * food in items) 
    {        
        //GHAssertGreaterThan([food.unitWeights count], (uint)0,  @"found food with no unit weights %@", food.ndbNo);
        if([food.unitWeights count] < 1){
            GHTestLog(@"found food with no unit weights %@ - %@", food.ndbNo, food.descriptionShort);
        }
    }
    
}

-(void) testFoodHasGroup
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[Food entityName] inManagedObjectContext:[self managedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    for (Food * food in items) 
    {        
        GHAssertNotNil(food.group, @"found food with no group %@", food.ndbNo);
    }
}

@end
