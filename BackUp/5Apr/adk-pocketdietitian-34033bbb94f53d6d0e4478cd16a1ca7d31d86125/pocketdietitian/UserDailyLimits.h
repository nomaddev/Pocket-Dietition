//
//  UsersDiet.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/18/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NutrientAmount;

@interface UserDailyLimits : NSObject{
    
@private NSMutableDictionary* userNutrientAmounts;
    
}
@property (nonatomic, strong) NSDate* date;
- (NutrientAmount *) nutrientAmountForNutrientNumber:(NSString *)parameterNutrientNumber;

- (NSArray *) trackedNutrientNumbers;

- (void) addNutrientAmount:(NutrientAmount *) parameterNutrientAmount forNutrientNumber:(NSString *) parameterNutrientNumber;
- (void) removeNutrientAmountForNutrientNumber:(NSString *)parameterNutrientNumber;
- (void) clear;

@end
