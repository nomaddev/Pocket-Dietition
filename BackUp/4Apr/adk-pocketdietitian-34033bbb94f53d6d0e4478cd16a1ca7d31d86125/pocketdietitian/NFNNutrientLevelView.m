//
//  NFNNutrientLevelView.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/21/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NFNNutrientLevelView.h"

#import "Meal.h"
#import "WarningState.h"
#import "Constants.h"
#import "UserDailyLimits.h"
#import "NutrientAmount.h"
#import "Nutrient.h"

#import "NSObject+NutrientDataHelper.h"

#import "AppDelegate.h"

#import "NutrientWarningCalculator.h"

@implementation NFNNutrientLevelView

@synthesize nutrientLabel;
@synthesize progressView;
@synthesize warning;
@synthesize warningState;
@synthesize nutrientNo;
@synthesize nutrientName;
@synthesize nutrientLimit;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 @abstract Creates a NFNNutrientLevelView for use in a UITableView
 @return a NFNNutrientLevelView
 */
+ (NFNNutrientLevelView *) nutrientLevelBlankView{
    NFNNutrientLevelView *cell = nil;
    
    //    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NFNFoodTableCell" owner:nil options:nil];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NFNNutrientLevelView" owner:nil options:nil];
    for(id currentObject in topLevelObjects)
    {
        if([currentObject isKindOfClass:[NFNNutrientLevelView class]])
        {
            cell = (NFNNutrientLevelView *)currentObject;
            
            break;
        }
    }
    
    return  cell;
}

+ (NFNNutrientLevelView *) viewForNutrientNo:(NSString *) nutrientNumber andLimits:(UserDailyLimits *)dailyLimits
{
    NFNNutrientLevelView *cell = [self nutrientLevelBlankView];
    cell.nutrientNo = nutrientNumber;
    
    NutrientAmount *maxAmount = [dailyLimits nutrientAmountForNutrientNumber:nutrientNumber];
    
    NSLog(@"max: %f; nutNo: %@", maxAmount.quantity, nutrientNumber);
    
    cell.progressView.maxValue = maxAmount.quantity;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    cell.nutrientName = [self findNutrientWithNutrientNumber:nutrientNumber usingManagedContext:context].name;
    cell.nutrientLabel.text = [[NSString alloc] initWithFormat:@"%@ (%d%@)", cell.nutrientName, (int)maxAmount.quantity, maxAmount.unit]; 
    
    return cell;
}


-(void) showWarning:(WarningState *) warningStateParam withTarget:(id) target andSelector:(SEL)selector
{
//    NSLog(@"!!!!!!!!!!!!!!!!!! show warning");
    
    self.warningState = warningStateParam;
    
    NSString *imgName = [NSString stringWithFormat:@"warning_icon_%@.png", warningStateParam.warningSeverity==2 ? @"red" : @"yellow"];
    
//    NSLog(@"name: %@", imgName);
    
    UIImage *warningImg = [UIImage imageNamed:imgName];
  
    UIButton *warningBtn = self.warning;
    [warningBtn setImage:warningImg forState:UIControlStateNormal];
    
    [warningBtn addTarget:target
                   action:selector
         forControlEvents:UIControlEventTouchUpInside];
    
    warningBtn.hidden = NO; 
}

- (void)checkConsumedDailyTotals
{
    float currentProgress = self.progressView.progress;
    // check daily totals
    //color standard bar if already over daily total thresholds
    if (currentProgress > kRED_THRESHOLD)
    {
        [self.progressView setFilledSectionColor:Red];
        [self.progressView setTransparentSectionColor:Red];
    }
    else if (currentProgress > kYELLOW_THRESHOLD)
    {
        [self.progressView setFilledSectionColor:Yellow];
        [self.progressView setTransparentSectionColor:Yellow];
    }
    else
    {
        [self.progressView setFilledSectionColor:Blue];
        [self.progressView setTransparentSectionColor:Blue];
    }
}

-(BarColor) barColorForSeverity:(int) severity
{
    //these happen to correspond - adjust if this changes
    return (BarColor)severity;
}

- (void)setColorsAndWarningsWithTarget:(id) target andSelector:(SEL)selector
{
    
    [self checkConsumedDailyTotals];
    
    
    WarningState *mostSevereWarningState = [NutrientWarningCalculator warningStateForNutrientNo:nutrientNo andPlannedLevel:self.progressView.transparentProgress andConsumedLevel:self.progressView.progress];
    
    if (mostSevereWarningState.warningSeverity!=kNO_WARNING)
        [((NFNNutrientLevelView *)[progressView superview]) showWarning:mostSevereWarningState withTarget:target andSelector:selector];
    
    [progressView setTransparentSectionColor:[self barColorForSeverity:mostSevereWarningState.warningSeverity]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
