// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FoodNutrientData.h instead.

#import <CoreData/CoreData.h>


extern const struct FoodNutrientDataAttributes {
	__unsafe_unretained NSString *foodNdbNo;
	__unsafe_unretained NSString *nutrientNo;
	__unsafe_unretained NSString *nutrientValue;
} FoodNutrientDataAttributes;

extern const struct FoodNutrientDataRelationships {
	__unsafe_unretained NSString *nutrient;
} FoodNutrientDataRelationships;

extern const struct FoodNutrientDataFetchedProperties {
} FoodNutrientDataFetchedProperties;

@class Nutrient;





@interface FoodNutrientDataID : NSManagedObjectID {}
@end

@interface _FoodNutrientData : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FoodNutrientDataID*)objectID;




@property (nonatomic, strong) NSString *foodNdbNo;


//- (BOOL)validateFoodNdbNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *nutrientNo;


//- (BOOL)validateNutrientNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *nutrientValue;


@property double nutrientValueValue;
- (double)nutrientValueValue;
- (void)setNutrientValueValue:(double)value_;

//- (BOOL)validateNutrientValue:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Nutrient* nutrient;

//- (BOOL)validateNutrient:(id*)value_ error:(NSError**)error_;




@end

@interface _FoodNutrientData (CoreDataGeneratedAccessors)

@end

@interface _FoodNutrientData (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveFoodNdbNo;
- (void)setPrimitiveFoodNdbNo:(NSString*)value;




- (NSString*)primitiveNutrientNo;
- (void)setPrimitiveNutrientNo:(NSString*)value;




- (NSNumber*)primitiveNutrientValue;
- (void)setPrimitiveNutrientValue:(NSNumber*)value;

- (double)primitiveNutrientValueValue;
- (void)setPrimitiveNutrientValueValue:(double)value_;





- (Nutrient*)primitiveNutrient;
- (void)setPrimitiveNutrient:(Nutrient*)value;


@end
