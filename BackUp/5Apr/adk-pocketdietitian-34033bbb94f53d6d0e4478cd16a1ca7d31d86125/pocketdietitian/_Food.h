// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Food.h instead.

#import <CoreData/CoreData.h>


extern const struct FoodAttributes {
	__unsafe_unretained NSString *commonNames;
	__unsafe_unretained NSString *descriptionLong;
	__unsafe_unretained NSString *descriptionShort;
	__unsafe_unretained NSString *foodGroupCode;
	__unsafe_unretained NSString *manufacturer;
	__unsafe_unretained NSString *ndbNo;
} FoodAttributes;

extern const struct FoodRelationships {
	__unsafe_unretained NSString *group;
	__unsafe_unretained NSString *nutrients;
	__unsafe_unretained NSString *unitWeights;
} FoodRelationships;

extern const struct FoodFetchedProperties {
} FoodFetchedProperties;

@class FoodGroup;
@class FoodNutrientData;
@class FoodUnitWeight;








@interface FoodID : NSManagedObjectID {}
@end

@interface _Food : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FoodID*)objectID;




@property (nonatomic, strong) NSString *commonNames;


//- (BOOL)validateCommonNames:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *descriptionLong;


//- (BOOL)validateDescriptionLong:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *descriptionShort;


//- (BOOL)validateDescriptionShort:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *foodGroupCode;


//- (BOOL)validateFoodGroupCode:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *manufacturer;


//- (BOOL)validateManufacturer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *ndbNo;


//- (BOOL)validateNdbNo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) FoodGroup* group;

//- (BOOL)validateGroup:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* nutrients;

- (NSMutableSet*)nutrientsSet;




@property (nonatomic, strong) NSSet* unitWeights;

- (NSMutableSet*)unitWeightsSet;




@end

@interface _Food (CoreDataGeneratedAccessors)

- (void)addNutrients:(NSSet*)value_;
- (void)removeNutrients:(NSSet*)value_;
- (void)addNutrientsObject:(FoodNutrientData*)value_;
- (void)removeNutrientsObject:(FoodNutrientData*)value_;

- (void)addUnitWeights:(NSSet*)value_;
- (void)removeUnitWeights:(NSSet*)value_;
- (void)addUnitWeightsObject:(FoodUnitWeight*)value_;
- (void)removeUnitWeightsObject:(FoodUnitWeight*)value_;

@end

@interface _Food (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCommonNames;
- (void)setPrimitiveCommonNames:(NSString*)value;




- (NSString*)primitiveDescriptionLong;
- (void)setPrimitiveDescriptionLong:(NSString*)value;




- (NSString*)primitiveDescriptionShort;
- (void)setPrimitiveDescriptionShort:(NSString*)value;




- (NSString*)primitiveFoodGroupCode;
- (void)setPrimitiveFoodGroupCode:(NSString*)value;




- (NSString*)primitiveManufacturer;
- (void)setPrimitiveManufacturer:(NSString*)value;




- (NSString*)primitiveNdbNo;
- (void)setPrimitiveNdbNo:(NSString*)value;





- (FoodGroup*)primitiveGroup;
- (void)setPrimitiveGroup:(FoodGroup*)value;



- (NSMutableSet*)primitiveNutrients;
- (void)setPrimitiveNutrients:(NSMutableSet*)value;



- (NSMutableSet*)primitiveUnitWeights;
- (void)setPrimitiveUnitWeights:(NSMutableSet*)value;


@end
