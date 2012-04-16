// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Nutrient.h instead.

#import <CoreData/CoreData.h>


extern const struct NutrientAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *nutrientNo;
	__unsafe_unretained NSString *units;
} NutrientAttributes;

extern const struct NutrientRelationships {
} NutrientRelationships;

extern const struct NutrientFetchedProperties {
} NutrientFetchedProperties;






@interface NutrientID : NSManagedObjectID {}
@end

@interface _Nutrient : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NutrientID*)objectID;




@property (nonatomic, strong) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *nutrientNo;


//- (BOOL)validateNutrientNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *units;


//- (BOOL)validateUnits:(id*)value_ error:(NSError**)error_;





@end

@interface _Nutrient (CoreDataGeneratedAccessors)

@end

@interface _Nutrient (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveNutrientNo;
- (void)setPrimitiveNutrientNo:(NSString*)value;




- (NSString*)primitiveUnits;
- (void)setPrimitiveUnits:(NSString*)value;




@end
