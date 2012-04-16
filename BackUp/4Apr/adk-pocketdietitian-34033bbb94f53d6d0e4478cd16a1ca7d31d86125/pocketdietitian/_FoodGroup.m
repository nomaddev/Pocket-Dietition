// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FoodGroup.m instead.

#import "_FoodGroup.h"

const struct FoodGroupAttributes FoodGroupAttributes = {
	.code = @"code",
	.name = @"name",
};

const struct FoodGroupRelationships FoodGroupRelationships = {
	.foods = @"foods",
};

const struct FoodGroupFetchedProperties FoodGroupFetchedProperties = {
};

@implementation FoodGroupID
@end

@implementation _FoodGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FoodGroup" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FoodGroup";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FoodGroup" inManagedObjectContext:moc_];
}

- (FoodGroupID*)objectID {
	return (FoodGroupID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic code;






@dynamic name;






@dynamic foods;

	
- (NSMutableSet*)foodsSet {
	[self willAccessValueForKey:@"foods"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"foods"];
  
	[self didAccessValueForKey:@"foods"];
	return result;
}
	





@end
