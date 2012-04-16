// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FoodNutrientData.m instead.

#import "_FoodNutrientData.h"

const struct FoodNutrientDataAttributes FoodNutrientDataAttributes = {
	.foodNdbNo = @"foodNdbNo",
	.nutrientNo = @"nutrientNo",
	.nutrientValue = @"nutrientValue",
};

const struct FoodNutrientDataRelationships FoodNutrientDataRelationships = {
	.nutrient = @"nutrient",
};

const struct FoodNutrientDataFetchedProperties FoodNutrientDataFetchedProperties = {
};

@implementation FoodNutrientDataID
@end

@implementation _FoodNutrientData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FoodNutrientData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FoodNutrientData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FoodNutrientData" inManagedObjectContext:moc_];
}

- (FoodNutrientDataID*)objectID {
	return (FoodNutrientDataID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"nutrientValueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nutrientValue"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic foodNdbNo;






@dynamic nutrientNo;






@dynamic nutrientValue;



- (double)nutrientValueValue {
	NSNumber *result = [self nutrientValue];
	return [result doubleValue];
}

- (void)setNutrientValueValue:(double)value_ {
	[self setNutrientValue:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveNutrientValueValue {
	NSNumber *result = [self primitiveNutrientValue];
	return [result doubleValue];
}

- (void)setPrimitiveNutrientValueValue:(double)value_ {
	[self setPrimitiveNutrientValue:[NSNumber numberWithDouble:value_]];
}





@dynamic nutrient;

	





@end
