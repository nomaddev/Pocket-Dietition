//
//  NSManagedObjectContext+SingleLineFetch.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/9/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (SingleLineFetch)

- (NSSet *)fetchObjectsForEntityName:(NSString *)newEntityName
                       withPredicate:(id)stringOrPredicate, ...;

@end
