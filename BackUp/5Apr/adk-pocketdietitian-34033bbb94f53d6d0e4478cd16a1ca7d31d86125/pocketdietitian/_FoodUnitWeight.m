// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FoodUnitWeight.m instead.

#import "_FoodUnitWeight.h"

const struct FoodUnitWeightAttributes FoodUnitWeightAttributes = {
	.amount = @"amount",
	.gramWeight = @"gramWeight",
	.ndbNo = @"ndbNo",
	.sequenceNo = @"sequenceNo",
	.unitName = @"unitName",
};

const struct FoodUnitWeightRelationships FoodUnitWeightRelationships = {
};

const struct FoodUnitWeightFetchedProperties FoodUnitWeightFetchedProperties = {
};

@implementation FoodUnitWeightID
@end

@implementation _FoodUnitWeight

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FoodUnitWeight" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FoodUnitWeight";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FoodUnitWeight" inManagedObjectContext:moc_];
}

- (FoodUnitWeightID*)objectID {
	return (FoodUnitWeightID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"amountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"amount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"gramWeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"gramWeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic amount;



- (double)amountValue {
	NSNumber *result = [self amount];
	return [result doubleValue];
}

- (void)setAmountValue:(double)value_ {
	[self setAmount:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveAmountValue {
	NSNumber *result = [self primitiveAmount];
	return [result doubleValue];
}

- (void)setPrimitiveAmountValue:(double)value_ {
	[self setPrimitiveAmount:[NSNumber numberWithDouble:value_]];
}





@dynamic gramWeight;



- (double)gramWeightValue {
	NSNumber *result = [self gramWeight];
	return [result doubleValue];
}

- (void)setGramWeightValue:(double)value_ {
	[self setGramWeight:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveGramWeightValue {
	NSNumber *result = [self primitiveGramWeight];
	return [result doubleValue];
}

- (void)setPrimitiveGramWeightValue:(double)value_ {
	[self setPrimitiveGramWeight:[NSNumber numberWithDouble:value_]];
}





@dynamic ndbNo;






@dynamic sequenceNo;






@dynamic unitName;










@end
