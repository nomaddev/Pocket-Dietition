// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NutrientLevel.m instead.

#import "_NutrientLevel.h"

const struct NutrientLevelAttributes NutrientLevelAttributes = {
	.allowed = @"allowed",
	.consumed = @"consumed",
};

const struct NutrientLevelRelationships NutrientLevelRelationships = {
	.nutrient = @"nutrient",
};

const struct NutrientLevelFetchedProperties NutrientLevelFetchedProperties = {
};

@implementation NutrientLevelID
@end

@implementation _NutrientLevel

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NutrientLevel" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NutrientLevel";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NutrientLevel" inManagedObjectContext:moc_];
}

- (NutrientLevelID*)objectID {
	return (NutrientLevelID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"allowedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"allowed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"consumedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"consumed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic allowed;



- (float)allowedValue {
	NSNumber *result = [self allowed];
	return [result floatValue];
}

- (void)setAllowedValue:(float)value_ {
	[self setAllowed:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveAllowedValue {
	NSNumber *result = [self primitiveAllowed];
	return [result floatValue];
}

- (void)setPrimitiveAllowedValue:(float)value_ {
	[self setPrimitiveAllowed:[NSNumber numberWithFloat:value_]];
}





@dynamic consumed;



- (float)consumedValue {
	NSNumber *result = [self consumed];
	return [result floatValue];
}

- (void)setConsumedValue:(float)value_ {
	[self setConsumed:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveConsumedValue {
	NSNumber *result = [self primitiveConsumed];
	return [result floatValue];
}

- (void)setPrimitiveConsumedValue:(float)value_ {
	[self setPrimitiveConsumed:[NSNumber numberWithFloat:value_]];
}





@dynamic nutrient;

	






@end
