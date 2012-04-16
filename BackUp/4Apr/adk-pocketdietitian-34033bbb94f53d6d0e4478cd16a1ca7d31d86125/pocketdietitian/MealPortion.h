//
//  MealPortion.h
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/8/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Food;
@class FoodUnitWeight;
@class NFNNumber;
@class NutrientAmount;

@interface MealPortion : NSObject<NSCopying>{
    
@private NSMutableDictionary *nutrientInfoDictionary;
}

@property (nonatomic, strong)Food* food;
// How much of the food unit weight was consumed
@property (nonatomic, strong) NFNNumber* quantity;
// The unit of consumption, eg: oz, grams, slices, etc.
@property (nonatomic, strong)FoodUnitWeight* foodUnitWeight;

-(NutrientAmount *) nutrientInfoForNutrientNumber:(NSString *) parameterNutrientNumber;
/*
-(NutrientInfo*) sodium;
-(NutrientInfo*) potassium;
 */
 
 
@end
