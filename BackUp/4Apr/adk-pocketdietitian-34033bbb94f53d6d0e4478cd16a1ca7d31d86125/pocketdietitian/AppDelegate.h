//
//  AppDelegate.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/24/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class BaseViewController;
@class TermsAndConditionView;
@class UserConsumedNutrientLevelsAndLimits;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    /*!
     @abstract Nutrient levels for the application's user
     */
    @private UserConsumedNutrientLevelsAndLimits *userNutrientLevels;

}

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) BaseViewController *rootViewController;
@property (strong, nonatomic) TermsAndConditionView *rootViewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

/*!
 @abstract Nutrient levels being tracked for the user for the current day.
 @discussion Nutrient levels are tracked for the daily and are based of the UserDailyLimits determined by the user.
 @return UserNutrientLevels for the day
 */
-(UserConsumedNutrientLevelsAndLimits *) userConsumedNutrientLevelsForToday;
@end
