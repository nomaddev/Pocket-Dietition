// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DailyNutrientLevels.m instead.

#import "_DailyNutrientLevels.h"

const struct DailyNutrientLevelsAttributes DailyNutrientLevelsAttributes = {
	.date = @"date",
};

const struct DailyNutrientLevelsRelationships DailyNutrientLevelsRelationships = {
	.nutrientLevels = @"nutrientLevels",
};

const struct DailyNutrientLevelsFetchedProperties DailyNutrientLevelsFetchedProperties = {
};

@implementation DailyNutrientLevelsID
@end

@implementation _DailyNutrientLevels

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"DailyNutrientLevels" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"DailyNutrientLevels";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"DailyNutrientLevels" inManagedObjectContext:moc_];
}

- (DailyNutrientLevelsID*)objectID {
	return (DailyNutrientLevelsID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic date;






@dynamic nutrientLevels;

	
- (NSMutableSet*)nutrientLevelsSet {
	[self willAccessValueForKey:@"nutrientLevels"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"nutrientLevels"];
  
	[self didAccessValueForKey:@"nutrientLevels"];
	return result;
}
	






@end
