// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Food.m instead.

#import "_Food.h"

const struct FoodAttributes FoodAttributes = {
	.commonNames = @"commonNames",
	.descriptionLong = @"descriptionLong",
	.descriptionShort = @"descriptionShort",
	.foodGroupCode = @"foodGroupCode",
	.manufacturer = @"manufacturer",
	.ndbNo = @"ndbNo",
};

const struct FoodRelationships FoodRelationships = {
	.group = @"group",
	.nutrients = @"nutrients",
	.unitWeights = @"unitWeights",
};

const struct FoodFetchedProperties FoodFetchedProperties = {
};

@implementation FoodID
@end

@implementation _Food

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Food";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Food" inManagedObjectContext:moc_];
}

- (FoodID*)objectID {
	return (FoodID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic commonNames;






@dynamic descriptionLong;






@dynamic descriptionShort;






@dynamic foodGroupCode;






@dynamic manufacturer;






@dynamic ndbNo;






@dynamic group;

	

@dynamic nutrients;

	
- (NSMutableSet*)nutrientsSet {
	[self willAccessValueForKey:@"nutrients"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"nutrients"];
  
	[self didAccessValueForKey:@"nutrients"];
	return result;
}
	

@dynamic unitWeights;

	
- (NSMutableSet*)unitWeightsSet {
	[self willAccessValueForKey:@"unitWeights"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"unitWeights"];
  
	[self didAccessValueForKey:@"unitWeights"];
	return result;
}
	





@end
