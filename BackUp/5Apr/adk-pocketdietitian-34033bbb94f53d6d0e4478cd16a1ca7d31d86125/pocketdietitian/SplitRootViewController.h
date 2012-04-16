//
//  SplitRootViewController.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/7/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "BaseViewController.h"

@class NFNCustomProgressViewDrawRect;
@class UserConsumedNutrientLevelsAndLimits;

@interface SplitRootViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    @private
    NSMutableDictionary *progressViews;
    NSString *nfnNutrientLevelViewCellIdentifier;
    float nutrientLevelRowHeight;
    /*!
     @abstract Nutrient levels being tracked for the user.
     */
    UserConsumedNutrientLevelsAndLimits *userConsumedNutrientLevelsAndLimits;
    UIView *nutrientTableFooterView;
    int nutrientWarningCount;
}

@property (unsafe_unretained, nonatomic) IBOutlet UIView *topHalfView;
@property (strong, nonatomic) UINavigationController *mealNavController;

- (IBAction)addMealTapped:(id)sender;
- (IBAction)EditDietTapped:(id)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *bottomHalfView;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *nutrientTableView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *numWarningsLabel;


@end
