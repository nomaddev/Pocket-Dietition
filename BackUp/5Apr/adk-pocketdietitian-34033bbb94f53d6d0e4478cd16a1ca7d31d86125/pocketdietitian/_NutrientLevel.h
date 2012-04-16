// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NutrientLevel.h instead.

#import <CoreData/CoreData.h>


extern const struct NutrientLevelAttributes {
	__unsafe_unretained NSString *allowed;
	__unsafe_unretained NSString *consumed;
} NutrientLevelAttributes;

extern const struct NutrientLevelRelationships {
	__unsafe_unretained NSString *nutrient;
} NutrientLevelRelationships;

extern const struct NutrientLevelFetchedProperties {
} NutrientLevelFetchedProperties;

@class Nutrient;




@interface NutrientLevelID : NSManagedObjectID {}
@end

@interface _NutrientLevel : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NutrientLevelID*)objectID;




@property (nonatomic, strong) NSNumber *allowed;


@property float allowedValue;
- (float)allowedValue;
- (void)setAllowedValue:(float)value_;

//- (BOOL)validateAllowed:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *consumed;


@property float consumedValue;
- (float)consumedValue;
- (void)setConsumedValue:(float)value_;

//- (BOOL)validateConsumed:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Nutrient* nutrient;

//- (BOOL)validateNutrient:(id*)value_ error:(NSError**)error_;





@end

@interface _NutrientLevel (CoreDataGeneratedAccessors)

@end

@interface _NutrientLevel (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber *)primitiveAllowed;
- (void)setPrimitiveAllowed:(NSNumber *)value;

- (float)primitiveAllowedValue;
- (void)setPrimitiveAllowedValue:(float)value_;




- (NSNumber *)primitiveConsumed;
- (void)setPrimitiveConsumed:(NSNumber *)value;

- (float)primitiveConsumedValue;
- (void)setPrimitiveConsumedValue:(float)value_;





- (Nutrient*)primitiveNutrient;
- (void)setPrimitiveNutrient:(Nutrient*)value;


@end
