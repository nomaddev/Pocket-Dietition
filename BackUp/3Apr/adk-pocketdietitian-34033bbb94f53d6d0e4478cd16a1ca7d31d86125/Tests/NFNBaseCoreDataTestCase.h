//
//  UsdaDataModelTest.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/24/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h> 


@interface NFNBaseCoreDataTestCase : GHTestCase 


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
-(void) deleteAll:(NSString *) entityName;
- (NSURL *)applicationDocumentsDirectory;
-(NSURL *) getStoreURL;

@end

