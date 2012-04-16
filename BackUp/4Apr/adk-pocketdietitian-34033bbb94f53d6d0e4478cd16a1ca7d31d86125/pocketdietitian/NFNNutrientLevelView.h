//
//  NFNNutrientLevelView.h
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/21/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NFNProgressView;

@class WarningState;
@class NutrientAmount;
@class UserDailyLimits;

@interface NFNNutrientLevelView : UITableViewCell

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *nutrientLabel;
@property (unsafe_unretained, nonatomic) IBOutlet NFNProgressView *progressView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *warning;


@property (strong, nonatomic) WarningState *warningState;
@property (strong, nonatomic) NSString *nutrientNo;
@property (strong, nonatomic) NSString *nutrientName;
@property (strong, nonatomic) NutrientAmount *nutrientLimit;

- (void) showWarning:(WarningState *) warning withTarget:(id) target andSelector:(SEL)selector;
- (void)setColorsAndWarningsWithTarget:(id) target andSelector:(SEL)selector;
+ (NFNNutrientLevelView *) nutrientLevelBlankView;
+ (NFNNutrientLevelView *) viewForNutrientNo:(NSString *) nutrientNumber andLimits:(UserDailyLimits *)dailyLimits;
@end

