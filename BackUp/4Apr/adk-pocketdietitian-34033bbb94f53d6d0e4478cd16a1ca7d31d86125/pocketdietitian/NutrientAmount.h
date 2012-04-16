//
//  NutrientInfo.h
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/15/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoodNutrientData;
@interface NutrientAmount : NSObject<NSCopying>
    
@property (nonatomic, strong) NSString *unit ;
@property (nonatomic, unsafe_unretained) float quantity ;

+(NutrientAmount *) nutrientAmountWithQuantity:(float) quantity andUnit:(NSString*) unit;

@end
