// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DailyNutrientLevels.h instead.

#import <CoreData/CoreData.h>


extern const struct DailyNutrientLevelsAttributes {
	__unsafe_unretained NSString *date;
} DailyNutrientLevelsAttributes;

extern const struct DailyNutrientLevelsRelationships {
	__unsafe_unretained NSString *nutrientLevels;
} DailyNutrientLevelsRelationships;

extern const struct DailyNutrientLevelsFetchedProperties {
} DailyNutrientLevelsFetchedProperties;

@class NutrientLevel;



@interface DailyNutrientLevelsID : NSManagedObjectID {}
@end

@interface _DailyNutrientLevels : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (DailyNutrientLevelsID*)objectID;




@property (nonatomic, strong) NSDate *date;


//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* nutrientLevels;

- (NSMutableSet*)nutrientLevelsSet;





@end

@interface _DailyNutrientLevels (CoreDataGeneratedAccessors)

- (void)addNutrientLevels:(NSSet*)value_;
- (void)removeNutrientLevels:(NSSet*)value_;
- (void)addNutrientLevelsObject:(NutrientLevel*)value_;
- (void)removeNutrientLevelsObject:(NutrientLevel*)value_;

@end

@interface _DailyNutrientLevels (CoreDataGeneratedPrimitiveAccessors)


- (NSDate *)primitiveDate;
- (void)setPrimitiveDate:(NSDate *)value;





- (NSMutableSet*)primitiveNutrientLevels;
- (void)setPrimitiveNutrientLevels:(NSMutableSet*)value;


@end
