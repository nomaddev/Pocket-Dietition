// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FoodGroup.h instead.

#import <CoreData/CoreData.h>


extern const struct FoodGroupAttributes {
	__unsafe_unretained NSString *code;
	__unsafe_unretained NSString *name;
} FoodGroupAttributes;

extern const struct FoodGroupRelationships {
	__unsafe_unretained NSString *foods;
} FoodGroupRelationships;

extern const struct FoodGroupFetchedProperties {
} FoodGroupFetchedProperties;

@class Food;




@interface FoodGroupID : NSManagedObjectID {}
@end

@interface _FoodGroup : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FoodGroupID*)objectID;




@property (nonatomic, strong) NSString *code;


//- (BOOL)validateCode:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* foods;

- (NSMutableSet*)foodsSet;




@end

@interface _FoodGroup (CoreDataGeneratedAccessors)

- (void)addFoods:(NSSet*)value_;
- (void)removeFoods:(NSSet*)value_;
- (void)addFoodsObject:(Food*)value_;
- (void)removeFoodsObject:(Food*)value_;

@end

@interface _FoodGroup (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCode;
- (void)setPrimitiveCode:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveFoods;
- (void)setPrimitiveFoods:(NSMutableSet*)value;


@end
