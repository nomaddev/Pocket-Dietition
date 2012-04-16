// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FoodUnitWeight.h instead.

#import <CoreData/CoreData.h>


extern const struct FoodUnitWeightAttributes {
	__unsafe_unretained NSString *amount;
	__unsafe_unretained NSString *gramWeight;
	__unsafe_unretained NSString *ndbNo;
	__unsafe_unretained NSString *sequenceNo;
	__unsafe_unretained NSString *unitName;
} FoodUnitWeightAttributes;

extern const struct FoodUnitWeightRelationships {
} FoodUnitWeightRelationships;

extern const struct FoodUnitWeightFetchedProperties {
} FoodUnitWeightFetchedProperties;








@interface FoodUnitWeightID : NSManagedObjectID {}
@end

@interface _FoodUnitWeight : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FoodUnitWeightID*)objectID;




@property (nonatomic, strong) NSNumber *amount;


@property double amountValue;
- (double)amountValue;
- (void)setAmountValue:(double)value_;

//- (BOOL)validateAmount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *gramWeight;


@property double gramWeightValue;
- (double)gramWeightValue;
- (void)setGramWeightValue:(double)value_;

//- (BOOL)validateGramWeight:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *ndbNo;


//- (BOOL)validateNdbNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *sequenceNo;


//- (BOOL)validateSequenceNo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *unitName;


//- (BOOL)validateUnitName:(id*)value_ error:(NSError**)error_;





@end

@interface _FoodUnitWeight (CoreDataGeneratedAccessors)

@end

@interface _FoodUnitWeight (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAmount;
- (void)setPrimitiveAmount:(NSNumber*)value;

- (double)primitiveAmountValue;
- (void)setPrimitiveAmountValue:(double)value_;




- (NSNumber*)primitiveGramWeight;
- (void)setPrimitiveGramWeight:(NSNumber*)value;

- (double)primitiveGramWeightValue;
- (void)setPrimitiveGramWeightValue:(double)value_;




- (NSString*)primitiveNdbNo;
- (void)setPrimitiveNdbNo:(NSString*)value;




- (NSString*)primitiveSequenceNo;
- (void)setPrimitiveSequenceNo:(NSString*)value;




- (NSString*)primitiveUnitName;
- (void)setPrimitiveUnitName:(NSString*)value;




@end
