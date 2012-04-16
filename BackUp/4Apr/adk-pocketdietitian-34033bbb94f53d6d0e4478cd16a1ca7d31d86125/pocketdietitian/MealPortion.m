//
//  MealPortion.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/8/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "MealPortion.h"
#import "Food.h"
#import "NFNNumber.h"
#import "FoodUnitWeight.h"
#import "FoodNutrientData.h"
#import "NutrientAmount.h"
#import "Nutrient.h"

@interface MealPortion()
-(void) setNutrientAmount:(__autoreleasing NutrientAmount**) nutrientInfo withNutrientData:(FoodNutrientData *) nutrientData;
-(void) sortNutrientData;

@end
@implementation MealPortion

@synthesize food;
@synthesize quantity;
@synthesize foodUnitWeight;
//NSString * const MEAL_PORTION_NUTRITION_SODIUM = @"sodium";
//NSString * const MEAL_PORTION_NUTRITION_POTASSIUM = @"potassium";


-(void) setQuantity:(NFNNumber *) parameterQuantity{
    quantity = parameterQuantity;
    //update all the nutrient info for this meal portion
    [self sortNutrientData];
}

- (id)initWithFood: (Food *) parameterFood 
{
    self = [super init];
    if (self) 
    {
        food = parameterFood;
        nutrientInfoDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        nutrientInfoDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void) setNutrientAmount:(__autoreleasing NutrientAmount**) nutrientInfo withNutrientData:(FoodNutrientData *) nutrientData
{
    float totalGramsConsumed =  [foodUnitWeight totalGramWeightForAmountConsumed:[ quantity valueAsNSNumber ]  ];
    
    *nutrientInfo = [[NutrientAmount alloc] init];
    (*nutrientInfo).quantity = [nutrientData nutrientValueForGramAmount:totalGramsConsumed];
    (*nutrientInfo).unit = nutrientData.nutrient.units;
        
}

-(void) sortNutrientData
{
    //NSMutableArray *nutrientsToTrack = [NSMutableArray arrayWithObjects:MEAL_PORTION_NUTRITION_SODIUM, MEAL_PORTION_NUTRITION_POTASSIUM, nil];
    
    // find each of the nutrients we care about and hold onto their nutrient info
   
    for (FoodNutrientData *nutData in food.nutrients)
    {
        NSString *trackedNutrient = nutData.nutrientNo;
        
        // update the nutrient info
        NutrientAmount *nutrientInfo = [nutrientInfoDictionary objectForKey:trackedNutrient];
        nutrientInfo = nutrientInfo ? nutrientInfo : [[NutrientAmount alloc] init];
        
        [self setNutrientAmount:&nutrientInfo withNutrientData:nutData];
        // save our nutrient to the nutrient info dictionary
        [nutrientInfoDictionary setObject:nutrientInfo forKey:trackedNutrient];
             
    }
        
}

-(NutrientAmount *) nutrientInfoForNutrientNumber:(NSString *) parameterNutrientNumber
{
    return [nutrientInfoDictionary objectForKey:parameterNutrientNumber];
}

/*
-(NutrientInfo*) sodium{
    return [nutrientInfoDictionary objectForKey:MEAL_PORTION_NUTRITION_SODIUM];
}

-(NutrientInfo*) potassium{
    return [nutrientInfoDictionary objectForKey:MEAL_PORTION_NUTRITION_POTASSIUM];
}
 */

#pragma NSCopying
- (id)copyWithZone:(NSZone *)zone{
    MealPortion *portionCopy = [[[self class] allocWithZone: zone] init];
    if(portionCopy){
        // shallow copies
        portionCopy.food = self.food;
        portionCopy.foodUnitWeight = self.foodUnitWeight;
        // deep copy
        portionCopy.quantity = self.quantity.copy;
        
    }
    return portionCopy;
    
}
@end
