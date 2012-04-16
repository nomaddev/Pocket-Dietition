//
//  USDADatabaseLoader.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/27/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USDADatabaseImporter : NSObject

+(BOOL) databaseExists:(NSURL*) storeURL;
+(void) importDatabase:(NSManagedObjectContext*) context;
+(void) removePersistentStoreAtUrl:(NSURL*) storeToRemove;

@end
