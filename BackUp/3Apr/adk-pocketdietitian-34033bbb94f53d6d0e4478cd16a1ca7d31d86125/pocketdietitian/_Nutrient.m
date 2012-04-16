// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Nutrient.m instead.

#import "_Nutrient.h"

const struct NutrientAttributes NutrientAttributes = {
	.name = @"name",
	.nutrientNo = @"nutrientNo",
	.units = @"units",
};

const struct NutrientRelationships NutrientRelationships = {
};

const struct NutrientFetchedProperties NutrientFetchedProperties = {
};

@implementation NutrientID
@end

@implementation _Nutrient

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Nutrient" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Nutrient";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Nutrient" inManagedObjectContext:moc_];
}

- (NutrientID*)objectID {
	return (NutrientID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic nutrientNo;






@dynamic units;










@end
