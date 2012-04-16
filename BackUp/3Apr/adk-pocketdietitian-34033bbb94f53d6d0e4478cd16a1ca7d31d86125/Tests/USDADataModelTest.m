//
//  USDADataModelTest.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/24/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NFNBaseCoreDataTestCase.h"
#import "FoodGroup.h"
#import "Food.h"

#import "Nutrient.h"
#import "FoodNutrientData.h"

@interface USDADataModelTest : NFNBaseCoreDataTestCase 

@end


@implementation USDADataModelTest


-(void) setUp
{
    //delete existing db every time - in case there is one left over from other tests
    [[NSFileManager defaultManager] removeItemAtURL:[self getStoreURL] error:nil];
    
    self.managedObjectContext = nil;
    self.managedObjectModel = nil;
    self.persistentStoreCoordinator = nil;
}

-(void) tearDown
{
    [self deleteAll:@"Food"];
    [self deleteAll:@"FoodGroup"];

}


- (void)testSaveFoodGroup 
{       
    NSManagedObjectContext *ctx = [self managedObjectContext];
    FoodGroup *group = [NSEntityDescription
                        insertNewObjectForEntityForName:@"FoodGroup" 
                        inManagedObjectContext:ctx];
    group.name = @"TestGroup";
    
    NSError *error;
    GHAssertTrue([[self managedObjectContext] save:&error], @"Whoops, couldn't save deletions: %@", [error localizedDescription]);
    NSLog(@"saved after insert");
    
    NSFetchRequest * allGroups = [[NSFetchRequest alloc] init];
    [allGroups setEntity:[NSEntityDescription entityForName:@"FoodGroup" inManagedObjectContext:[self managedObjectContext]]];
    
    error = nil;
    NSArray *groups = [[self managedObjectContext] executeFetchRequest:allGroups error:&error];
    
    NSLog(@"groups: %d", [groups count]);
    
    GHAssertGreaterThan([groups count], (uint)0, @"there were no groups post save");
    
    FoodGroup *newFoodGroup = [groups objectAtIndex:0];
    
    GHAssertEqualStrings(@"TestGroup", newFoodGroup.name, @"food group name did not match");
}

- (void)testSaveFood
{       
    NSManagedObjectContext *ctx = [self managedObjectContext];
    Food *food = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Food" 
                        inManagedObjectContext:ctx];
    food.descriptionShort = @"TestFood";
    
    NSError *error;
    GHAssertTrue([[self managedObjectContext] save:&error], @"Whoops, couldn't save deletions: %@", [error localizedDescription]);
    NSLog(@"saved after insert");
    
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:@"Food" inManagedObjectContext:[self managedObjectContext]]];
    
    error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    NSLog(@"count after save: %d", [items count]);
    
    GHAssertGreaterThan([items count], (uint)0, @"there were no items post save");
    
    Food *newFood = [items objectAtIndex:0];
    
    GHAssertEqualStrings(@"TestFood", newFood.descriptionShort, @"food name did not match");
}

//- (void)testFAIL
//{
//    GHAssertTrue(FALSE, @"FAIL"); 
//}
- (void)testFoodToGroupRelationship
{       
    NSManagedObjectContext *ctx = [self managedObjectContext];
    Food *food = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Food" 
                  inManagedObjectContext:ctx];
    food.descriptionShort = @"TestFood";
    
    FoodGroup *foodGroup = [NSEntityDescription
                  insertNewObjectForEntityForName:@"FoodGroup" 
                  inManagedObjectContext:ctx];
    foodGroup.name = @"TestGroup";
    
    //[foodGroup addFoodsObject:food];
    
    food.group = foodGroup;
    
    NSError *error;
    GHAssertTrue([[self managedObjectContext] save:&error], @"Whoops, couldn't save deletions: %@", [error localizedDescription]);
    NSLog(@"saved after insert");
    
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:@"Food" inManagedObjectContext:[self managedObjectContext]]];
    
    error = nil;
    
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    Food *newFood = [items objectAtIndex:0];
    
    FoodGroup *group  = newFood.group;
    
    GHAssertNotNil(group, @"food did not have group");
    NSLog(@"passed food->group test");
    
    GHAssertEqualStrings(group.name, @"TestGroup", @"group name was wrong");
    NSLog(@"group name was correct");    

    GHAssertTrue([group.foods containsObject:newFood], @"group did not contain food");
    NSLog(@"passed group->food test");  
   }

-(void) testNutrientDataNutrientRelationship
{
    NSString *nutNo = @"12345";
    
    NSManagedObjectContext *context = [self managedObjectContext];
    FoodNutrientData *nutrientData = [NSEntityDescription
                                      insertNewObjectForEntityForName:[FoodNutrientData entityName] 
                                      inManagedObjectContext:context];
    nutrientData.nutrientNo = nutNo;
    
    
    Nutrient *nutrient = [NSEntityDescription
                          insertNewObjectForEntityForName:[Nutrient entityName] 
                          inManagedObjectContext:context];
    
    nutrient.nutrientNo = nutNo;
    
    // associate the nutrient to the nutrient data
    nutrientData.nutrient = nutrient;
    
    NSError *error;
    GHAssertTrue([[self managedObjectContext] save:&error], @"Whoops, couldn't save deletions: %@", [error localizedDescription]);
    NSLog(@"saved after insert");

    
    NSFetchRequest * nutrData = [[NSFetchRequest alloc] init];
    [nutrData setEntity:[NSEntityDescription entityForName:[FoodNutrientData entityName] inManagedObjectContext:context]];
    [nutrData setPredicate:[NSPredicate predicateWithFormat:@"nutrientNo = %@", nutNo]];
    
    error = nil;
    NSArray *results = [context executeFetchRequest:nutrData error:&error];
    FoodNutrientData *fetchedNutData =  [results objectAtIndex:0];
    
    GHAssertNotNil(fetchedNutData.nutrient, @"nutrient was nil");
    
}

@end
