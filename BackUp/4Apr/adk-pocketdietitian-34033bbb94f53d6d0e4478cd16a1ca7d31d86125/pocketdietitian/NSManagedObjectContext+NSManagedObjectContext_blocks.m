//
//  NSManagedObjectContext+NSManagedObjectContext_blocks.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/9/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NSManagedObjectContextFetchCompleteBlock)(NSArray* results, id tag);
typedef void (^NSManagedObjectContextFetchFailBlock)(NSError *error, id tag);

@interface NSManagedObjectContext (NSManagedObjectContext_blocks)


-(void)executeFetchRequestInBackground:(NSFetchRequest*) aRequest 
                               withTag:(id) tag
							onComplete:(NSManagedObjectContextFetchCompleteBlock) completeBlock 
							   onError:(NSManagedObjectContextFetchFailBlock) failBlock;

@end

@implementation NSManagedObjectContext (NSManagedObjectContext_blocks)

-(void)executeFetchRequestInBackground:(NSFetchRequest*) aRequest 
                               withTag:(id) tag
							onComplete:(NSManagedObjectContextFetchCompleteBlock) completeBlock 
							   onError:(NSManagedObjectContextFetchFailBlock) failBlock{
    
	dispatch_queue_t	backgroundQueue	= dispatch_queue_create("FR.NSManagedObjectContext.fetchRequests", NULL);
	dispatch_queue_t	mainQueue		= dispatch_get_main_queue();
    
	//Change the fetch result type to object ids
	[aRequest setResultType:NSManagedObjectIDResultType];
    
	//Create a new context
	dispatch_async(backgroundQueue, ^{
        
		//Create a new managed object context
		NSManagedObjectContext	*threadContext;
		NSArray					*threadResults = nil;
		NSError					*error = nil;
        
		threadContext = [[NSManagedObjectContext alloc] init];
        
		[threadContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
        
		if( (threadResults = [threadContext executeFetchRequest:aRequest error:&error]) ){
            
			//Create a new array to place the results in
			//results = [[NSMutableArray alloc] initWithCapacity:[threadResults count]];
            
			//Call on the main thread
			dispatch_sync(mainQueue, ^{
                
				//Iterate over the objects
				//Re assign the objects to the correct (main) context
//				[threadResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *halt){
//                    
//					[results addObject:[self objectWithID:obj]];
//                    
//				}];				
                
                NSFetchRequest *rqst = [NSFetchRequest fetchRequestWithEntityName:aRequest.entityName];
                [rqst setPredicate:[NSPredicate predicateWithFormat:@"self IN %@", threadResults]];
                NSArray *finalResults = [self executeFetchRequest:rqst error:nil];
				
                completeBlock(finalResults, tag);
                
			});
            
		}
		else{
            
			//Call on the main thread
			dispatch_sync(mainQueue, ^{
				failBlock( error, tag );				
			});
		}
	});
}

@end