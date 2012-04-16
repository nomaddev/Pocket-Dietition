//
//  MealViewController.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/1/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class UserConsumedNutrientLevelsAndLimits;

@interface MealViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>{
    @private 
    /*!
     @abstract Nutrients levels being tracked for the user.
     */
    UserConsumedNutrientLevelsAndLimits *userNutrientLevels;
}

- (void)addFoodTapped;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *mealType;
- (IBAction)mealTypeTapped:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *mealPortionTableView;

@end
