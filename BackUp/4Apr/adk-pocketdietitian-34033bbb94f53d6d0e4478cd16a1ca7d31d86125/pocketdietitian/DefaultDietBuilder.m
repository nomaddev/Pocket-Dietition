//
//  DefaultDietBuilder.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/21/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "DefaultDietBuilder.h"
#import "UserDailyLimits.h"
#import "NutrientAmount.h"
@implementation DefaultDietBuilder

+ (void) defaultDiabeticDietForUserDailyLimit:(__autoreleasing UserDailyLimits **) parameterUserDiet;
{
    /*
     sodium 307
     potassium 306
     phosphorus 305
     protein 203
     (adjusted protein 257)
     fluids 255
     calories 208
     carbohydrates 205
     fat 204
     Cholesterol 601
     
     fiber 291*/
    //    Default Diabetic Diet
    //    2000 Kcals, 100gm Protein, 70gm Fat (50% carbohydrate, 20% protein, 30% fat)
    
    
    UserDailyLimits *userDiet = (*parameterUserDiet);
    // apply the nutrition info to the passed in user diet
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:2000 andUnit:@"kcal"] forNutrientNumber:@"208"];
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:100 andUnit:@"g"] forNutrientNumber:@"203"];
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:70 andUnit:@"g"] forNutrientNumber:@"204"];
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:250 andUnit:@"g"] forNutrientNumber:@"205"];
    
        
}

+ (void) defaultHypertensionDietForUserDailyLimit:(UserDailyLimits **) parameterUserDiet
{
    UserDailyLimits *userDiet = (*parameterUserDiet);
    // apply the nutrition info to the passed in user diet
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:2000 andUnit:@"kcal"] forNutrientNumber:@"208"];
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:90 andUnit:@"g"] forNutrientNumber:@"203"];
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:60 andUnit:@"g"] forNutrientNumber:@"204"];
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:250 andUnit:@"g"] forNutrientNumber:@"205"];
    
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:2000 andUnit:@"mg"] forNutrientNumber:@"307"];
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:4700 andUnit:@"mg"] forNutrientNumber:@"306"];
    
    [userDiet addNutrientAmount:[NutrientAmount nutrientAmountWithQuantity:30 andUnit:@"g"] forNutrientNumber:@"291"];
}
@end
