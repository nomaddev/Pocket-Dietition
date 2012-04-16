//
//  UserNutrientLevels.h
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/24/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserDailyLimits;
@class NutrientAmount;
@class DailyNutrientLevels;

/*!
 @class UserNutrientLevels
 @discussion Keeps track of the nutrient quantities for the user.
 */
@interface UserConsumedNutrientLevelsAndLimits : NSObject
{
@private NSMutableDictionary *nutrientConsumedAmountDictionary;
@private NSManagedObjectContext *managedObjectContext;
@private DailyNutrientLevels *dailyNutrientLevels;
    
}
/*!
 @abstract A user's max nutrient levels for the day.
 @discussion Setting a daily limit will trigger a reset.
 */
@property (nonatomic, strong) UserDailyLimits *dailyLimits;

/*!
 @abstract Retrieve an individual nutrient amount level.
 @discussion If the requested nutrient does not exist, one will be created if it is a nutrient
 meant to be tracked by the user's daily limit.
 @param inNutrientNumber
 The nutrient's number id
 @return NutrientAmount or nil if the nutrient is not being tracked.
 */
- (NutrientAmount *)nutrientConsumedAmountForNutrientNumber:(NSString *)inNutrientNumber;

/*!
 @abstract Retrieve all nutrient numbers being tracked for this user.
 @discussion The retrieved nutrient numbers will be from what has been determined as the 
 nutrients that the user wishes to have tracked.
 @return NSArray
 */
- (NSArray *) trackedNutrientNumbers;

/*!
 @abstract DailyNutrientLevels will be used to back this object.
 @param inDailyLevels
 CoreData object used to back UserNutrientLevels
 @param inDailyLimits
 The nutrients and max values being tracked
 @param inContext
 Managed object context used for persistence
 @return UserNutrientLevels
 */
- (id)initWithDailyLevels:(DailyNutrientLevels *)inDailyLevels dailyLimits:(UserDailyLimits *)inDailyLimits managedContext:(NSManagedObjectContext *)inContext;

/*!
 @abstract Adds the quantity of the nutrient amount to the current value of 
 the nutrient being tracked.
 @discussion The quantity of the new amount is added to the that of the old 
 amount if the nutrient is being tracked and are of the same units.
 @param inNutrientAmount
 The nutrient amount to add to an existing amount
 @param inNutrientNumber
 The nutrient to add the new amount to
 */
-(void)addNutrientAmount:(NutrientAmount *)inNutrientAmount toNutrientNumber:(NSString *)inNutrientNumber;

@end
