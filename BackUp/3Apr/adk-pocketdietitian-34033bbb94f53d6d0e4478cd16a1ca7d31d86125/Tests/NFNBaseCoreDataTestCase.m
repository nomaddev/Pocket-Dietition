//
//  UsdaDataModelTest.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/24/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NFNBaseCoreDataTestCase.h"


@implementation NFNBaseCoreDataTestCase
{
 
}

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;


-(void) copyOverExistingDatabase{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *masterDatabasePath = [[NSBundle mainBundle] pathForResource:@"pocketdietitian" ofType:@"sqlite"];
    if( [fileManager fileExistsAtPath:masterDatabasePath] ){
        // remove the target
        [fileManager removeItemAtURL:[self getStoreURL] error:nil];
        
        NSURL *masterDbPathAsURL = [NSURL fileURLWithPath:masterDatabasePath];
        GHTestLog(@"Copying %@ to %@", masterDbPathAsURL, [self getStoreURL] );
        [fileManager copyItemAtURL:masterDbPathAsURL toURL:[self getStoreURL] error:nil];
        
    }
}

-(void) setUp
{
    [self copyOverExistingDatabase];
}




-(void) tearDown
{
}

-(void) deleteAll:(NSString *) entityName
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]]];
    [allItems setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error = nil;
    NSArray *items = [[self managedObjectContext] executeFetchRequest:allItems error:&error];
    
    NSLog(@"deleting %d items", [items count]);
    
       for (NSManagedObject * item in items) {
        [[self managedObjectContext] deleteObject:item];
    }
    
    GHAssertTrue([[self managedObjectContext] save:&error], @"Whoops, couldn't save deletions: %@", [error localizedDescription]);
    
    NSLog(@"saved after delete");
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    
    
    __managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    //NSLog(@"ManagedObjectModel: %@", __managedObjectModel); 
    return __managedObjectModel;
}
//This is a global variable. To make this an instance variable put it in the interface section
NSURL * _storeURL;

-(NSURL *) getStoreURL
{
    
    if (!_storeURL)   
    {
        _storeURL  = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"pocketdietitian.sqlite"];
        
    }
    
    NSLog(@"db path: %@", [_storeURL path] );
    
    return _storeURL;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self getStoreURL] options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end