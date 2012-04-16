//
//  MealTest.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/17/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "MealTest.h"
#import "Food.h"
#import "FoodNutrientData.h"
#import "Nutrient.h"
#import "MealPortion.h"
#import "Meal.h"
#import "NutrientAmount.h"
#import "NFNNumber.h"

@implementation MealTest

-(Food *) foodWithNdbNumber:(NSString *) parameterNdbNumber{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest * foodFetchResult = [[NSFetchRequest alloc] init];
    [foodFetchResult setEntity:[NSEntityDescription entityForName:[Food entityName] inManagedObjectContext:context]];
    [foodFetchResult setPredicate:[NSPredicate predicateWithFormat:@"ndbNo = %@", parameterNdbNumber]];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:foodFetchResult error:&error];
    GHAssertNil(error, @"There was an error retreiving food with ndbNo: %@", parameterNdbNumber);
    
    Food *food =  [results objectAtIndex:0];
    
    return food;
}

-(MealPortion *) mealPortionForFoodWithNdbNumber:(NSString *) parameterNdbNumber{
    Food *food = [self foodWithNdbNumber:parameterNdbNumber];
    GHAssertNotNil(food.nutrients , @"nutrients was nil");
    
    MealPortion *mealPortion = [[MealPortion alloc]init ];
    mealPortion.food = food;
    return mealPortion;
}

//TODO move mealportion tests into their own test suite
-(void) testMealNutrition
{
    NSString *NUTRIENT_NUMBER_PROTEIN = @"203";
    NSString *SALTED_BUTTER = @"01001"; 
    NSString *BLUE_CHEESE = @"01004";
    NSArray *foodsInMeal = [NSArray arrayWithObjects:SALTED_BUTTER,BLUE_CHEESE, nil];
    
    Meal *testMeal = [[Meal alloc]init];
    
    float totalProtein = 0;
    // build a meal
    for(NSString *foodInMeal in foodsInMeal){
        MealPortion *mealPortion = [self mealPortionForFoodWithNdbNumber:foodInMeal];
        mealPortion.foodUnitWeight = [[mealPortion.food.unitWeights objectEnumerator]nextObject];
        mealPortion.quantity = [[NFNNumber alloc] initWithInteger:5 numerator:1 denominator:2];
        
        NutrientAmount *proteinInfo = [mealPortion nutrientInfoForNutrientNumber:NUTRIENT_NUMBER_PROTEIN];
        GHAssertNotNil(proteinInfo, @"Meal Portion did not store and retrieve nutrient info");
        GHAssertNotNil(proteinInfo.unit, @"No unit for the nutrient set.");
        GHAssertTrue(proteinInfo.quantity != 0, @"Quantity on nutrition info not set; %f == 0", proteinInfo.quantity );
        
        totalProtein += proteinInfo.quantity;
        
        [testMeal addMealPortion:mealPortion];
    }
    
    GHAssertTrue((uint)[testMeal numberOfMealPortions] == (uint)[foodsInMeal count], @"Number of meal portions not correct in the meal");
    
    float mealProteinTotal = [testMeal nutrientAmountForNutrientNumber:NUTRIENT_NUMBER_PROTEIN].quantity;
    GHAssertTrue(totalProtein == mealProteinTotal, @"protein values for the meal portion total (%f) did not match the meal(%f)", totalProtein, mealProteinTotal);
    
}

-(void) testMealPortionCopy{
    NSString *SALTED_BUTTER = @"01001"; 
    MealPortion *mealPortion = [self mealPortionForFoodWithNdbNumber:SALTED_BUTTER];
    mealPortion.foodUnitWeight = [[mealPortion.food.unitWeights objectEnumerator]nextObject];
    mealPortion.quantity = [[NFNNumber alloc] initWithInteger:5 numerator:1 denominator:2];
    
    MealPortion *portionCopy = [mealPortion copy];
    portionCopy.quantity.integer=20;
    
    GHAssertTrue(portionCopy.quantity.integer != mealPortion.quantity.integer, @"MealPortion copy had the same quantity as the original: %d == %d",portionCopy.quantity.integer, mealPortion.quantity.integer );
    
    GHAssertEquals(mealPortion.food, portionCopy.food, @"Food on copy is not the same as on the original");
    GHAssertEquals(mealPortion.foodUnitWeight, portionCopy.foodUnitWeight, @"FoodUnitWeight on copy is not the same as onn the original");
}

-(void) testMealPortionReplace{
    NSString *SALTED_BUTTER = @"01001"; 
    NSString *BLUE_CHEESE = @"01004";
    MealPortion *saltedButterPortion = [self mealPortionForFoodWithNdbNumber:SALTED_BUTTER];
    saltedButterPortion.foodUnitWeight = [[saltedButterPortion.food.unitWeights objectEnumerator]nextObject];
    saltedButterPortion.quantity = [[NFNNumber alloc] initWithInteger:5 numerator:1 denominator:2];
    
    Meal *meal = [[Meal alloc]init];
    [meal addMealPortion:saltedButterPortion];
    
    
    MealPortion *blueCheesePortion = [self mealPortionForFoodWithNdbNumber:BLUE_CHEESE];
    blueCheesePortion.foodUnitWeight = [[blueCheesePortion.food.unitWeights objectEnumerator]nextObject];
    blueCheesePortion.quantity = [[NFNNumber alloc] initWithInteger:7 numerator:1 denominator:5];
    
    // replace the original meal portion with the new one
    [meal replaceMealPortion:saltedButterPortion with:blueCheesePortion];
    
    MealPortion *firstMealPortion = [meal mealPortionAtIndex:0];
    GHAssertNotEquals(firstMealPortion, saltedButterPortion, @"Failed to replace meal portion");
    GHAssertEquals(firstMealPortion, blueCheesePortion, @"Failed to replace meal portion");
}

-(void) testMealPortionRemove{
    NSString *SALTED_BUTTER = @"01001"; 
    
    MealPortion *saltedButterPortion = [self mealPortionForFoodWithNdbNumber:SALTED_BUTTER];
    saltedButterPortion.foodUnitWeight = [[saltedButterPortion.food.unitWeights objectEnumerator]nextObject];
    saltedButterPortion.quantity = [[NFNNumber alloc] initWithInteger:5 numerator:1 denominator:2];
    
    Meal *meal = [[Meal alloc]init];
    [meal addMealPortion:saltedButterPortion];
    GHAssertTrue([meal numberOfMealPortions] == 1, @"Failed to add meal portion");

    
    // remove the meal portion
    [meal removeMealPortion:saltedButterPortion];
    
    GHAssertTrue([meal numberOfMealPortions] == 0, @"Failed to remove meal portion");
}

@end
