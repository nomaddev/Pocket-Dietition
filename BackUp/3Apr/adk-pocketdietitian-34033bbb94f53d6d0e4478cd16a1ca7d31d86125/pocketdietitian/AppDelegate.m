//
//  AppDelegate.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/24/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//


#import "AppDelegate.h"
#import "USDADatabaseImporter.h"
#import "SplitRootViewController.h"
#import "Food.h"
#import "UserConsumedNutrientLevelsAndLimits.h"
#import "UserDailyLimits.h"
#import "DefaultDietBuilder.h"
#import "DailyNutrientLevels.h"
#import "NutrientLevel.h"
#import "NutrientAmount.h"
#import "Nutrient.h"
#import "NSObject+NutrientDataHelper.h"
#import "TermsAndConditionView.h"

@implementation AppDelegate


@synthesize window = _window;
@synthesize rootViewController = _viewController;

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

NSURL *storeURL;

-(NSURL *) getStoreURL
{
    if (storeURL==nil)   
        storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"pocketdietitian.sqlite"];
    
     NSLog(@"db path: %@", [storeURL path] );
    
    return storeURL;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"didFinishLaunchingWithOptions");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // check for existing database and copy it into the documents directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *masterDatabasePath = [[NSBundle mainBundle] pathForResource:@"pocketdietitian" ofType:@"sqlite"];
    NSString *storePath = [[self getStoreURL] path];
    
    // check that we have a template database and that we don't 
    // already have a target one
    if( [fileManager fileExistsAtPath:masterDatabasePath] && 
        ![fileManager fileExistsAtPath:storePath]){
                
        NSURL *masterDbPathAsURL = [NSURL fileURLWithPath:masterDatabasePath];
        // Copy from the app bundle to the app's document location
        NSLog(@"Copying %@ to %@", masterDbPathAsURL, [self getStoreURL] );
        [fileManager copyItemAtURL:masterDbPathAsURL toURL:[self getStoreURL] error:nil];
        
//        if ([fileManager removeItemAtURL:masterDbPathAsURL error:nil])
//            NSLog(@"delete success");
        // Move from the app bundle to the app's document location
//        NSLog(@"Moving %@ to %@", masterDbPathAsURL, [self getStoreURL] );
//        NSError *error = nil;
//        if ([fileManager moveItemAtURL:masterDbPathAsURL toURL:[self getStoreURL] error:&error])
//            NSLog(@"success");
//        if (error!=nil)
//        {
//            NSLog(@"error: %@", [error  code]);
//        }
    }
    
    /* Create database from scratch. VERY time consuming
    if (![USDADatabaseImporter databaseExists:[self getStoreURL]])
    {
        [USDADatabaseImporter importDatabase:[self managedObjectContext]];
    }
    else
    {
        NSLog(@"database found, proceed without import");
    }
    */
    
    //launch default screen:
//    self.rootViewController = [[SplitRootViewController alloc] initWithNibName:@"SplitRootViewController" bundle:nil];
    
    UINavigationController *localNavigationController;
    
    self.rootViewController = [[TermsAndConditionView alloc] initWithNibName:@"TermsAndConditionView" bundle:nil];
    
    // create the nav controller and add the root view controller as its first view
    localNavigationController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    
     self.window.rootViewController = localNavigationController;
    
     [self.window makeKeyAndVisible];
    
     return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground");
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"applicationWillEnterForeground");
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
     NSLog(@"applicationWillTerminate");
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
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
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"pocketdietitian" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
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

#pragma mark - Domain objects methods
-(UserConsumedNutrientLevelsAndLimits *) userConsumedNutrientLevelsForToday{
    // give it up if we have nutrient levels for today
    if(userNutrientLevels) return userNutrientLevels;
    
    // use the levels we care about 
    UserDailyLimits *dailyLimits = [[UserDailyLimits alloc] init];
    //TODO pull from shared prefs
    [DefaultDietBuilder defaultHypertensionDietForUserDailyLimit:&dailyLimits];
    
    // grab the nutrient levels for today
    DailyNutrientLevels *levelsForToday = [self findDailyNutrientLevelsFor:[NSDate date] usingManagedContext:self.managedObjectContext];
    
    if(levelsForToday) NSLog(@"Found daily nutrient levels");
    if(!levelsForToday){
         NSLog(@"No daily nutrient levels");
        // create a new level for today
        levelsForToday = [self createDailyNutrientLevelsFor:[NSDate date] withLimits:dailyLimits usingManagedContext:self.managedObjectContext];
    }
    
    userNutrientLevels = [[UserConsumedNutrientLevelsAndLimits alloc] initWithDailyLevels:levelsForToday dailyLimits:dailyLimits managedContext:self.managedObjectContext];
    
           
    
    return userNutrientLevels;
}

@end
