//
//  NutrientInfo.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/15/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NutrientAmount.h"
#import "Nutrient.h"
#import "FoodNutrientData.h"

@implementation NutrientAmount

@synthesize unit;
@synthesize quantity;

+(NutrientAmount *) nutrientAmountWithQuantity:(float) quantity andUnit:(NSString*) unit
{
    NutrientAmount *amount = [[NutrientAmount alloc] init];
    amount.quantity = quantity;
    amount.unit = unit;
    
    return amount;
    
}

#pragma NSCopying
- (id)copyWithZone:(NSZone *)zone{
    NutrientAmount *amountCopy = [[[self class] allocWithZone: zone] init];
    if(amountCopy){
        amountCopy.quantity = self.quantity;
        amountCopy.unit     = [self.unit copy];
    }
    return amountCopy;
    
}
@end
