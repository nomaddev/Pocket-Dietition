//
//  SplitRootViewController.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/7/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "SplitRootViewController.h"

#import "MealViewController.h"
#import "NFNProgressView.h"
#import "Nutrient.h"
#import "Meal.h"
#import "UserDailyLimits.h"
#import "NutrientAmount.h"
#import "NFNNutrientLevelView.h"
#import "AppDelegate.h"
#import "UserConsumedNutrientLevelsAndLimits.h"
#import "Constants.h"
#import "WarningState.h"
#import "NutrientWarningCalculator.h"

#import "UIAlertView+MKBlockAdditions.h"

#import "NutrientLevelsFooter.h"
#import "MedicalConditions.h"

@implementation SplitRootViewController
@synthesize nutrientTableView;
@synthesize numWarningsLabel;
@synthesize bottomHalfView;
@synthesize topHalfView;
@synthesize mealNavController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = TRUE;
    
    // make sure we have the user's nutrient levels
    userConsumedNutrientLevelsAndLimits = [[self appDelegate] userConsumedNutrientLevelsForToday];
    
    progressViews = [[NSMutableDictionary alloc] initWithCapacity:[userConsumedNutrientLevelsAndLimits.trackedNutrientNumbers count]];
    
    //[self animateBars:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didUpdateMeal:) name:NOTIFICATION_MEAL_MEAL_PORTION_CHANGE object:nil];
//    [self didUpdateMeal:nil];   ---------------------------------     Commented By Tarak
    
}
-(void) didUpdateMeal:(NSNotification *) notification
{
    //[self animateBars:nil]; 
    //TODO: update # warnings labes
    nutrientWarningCount =  [NutrientWarningCalculator numberOfViolationsForUserConsumedNutrientLevelsAndLimits:userConsumedNutrientLevelsAndLimits forMeal:[Meal sharedInstance]];
    
    
    self.numWarningsLabel.text = [NSString stringWithFormat:@"%d warning%@", nutrientWarningCount, (nutrientWarningCount>1 ? @"s" : @"")];
    self.numWarningsLabel.hidden = (nutrientWarningCount==0);
    
    [nutrientTableView reloadData];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [self setTopHalfView:nil];
    [self setMealNavController:nil];
    [self setBottomHalfView:nil];
    [self setNutrientTableView:nil];
    [self setNumWarningsLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)viewWillAppear:(BOOL)animated 
{ 
	[super viewWillAppear:animated];
    
    /* This is necessary because if you add a UINavigationController as a subview of a UIViewController subclass, 
     you must explicitly call its viewWillAppear method from its container; otherwise, they won’t be called, 
     and when moving back and forth in the navigation tree, your UIViewControllers’ viewWillAppear: methods 
     won’t be called. 
     http://davidebenini.it/2009/01/03/viewwillappear-not-being-called-inside-a-uinavigationcontroller/*/
    
	[mealNavController viewWillAppear:animated];
    
    [nutrientTableView flashScrollIndicators];
    self.navigationController.navigationBarHidden = TRUE;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addMealTapped:(id)sender 
{
    mealNavController = [[UINavigationController alloc] initWithRootViewController:[[MealViewController alloc]init]];
    mealNavController.navigationBar.tintColor = [UIColor colorWithRed:32.00/256 green:134.00/256 blue:148.00/256 alpha:1];
    
    
    CGRect targetFrame = mealNavController.view.frame;
    
    mealNavController.view.frame = CGRectMake(0, 0-topHalfView.frame.size.height, mealNavController.view.frame.size.width, mealNavController.view.frame.size.height);
    [topHalfView addSubview:mealNavController.view];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         mealNavController.view.frame = targetFrame;
                     }
                     completion:^(BOOL finished){
                         //                         NSLog(@"Done!");
                     }];
}

- (IBAction)EditDietTapped:(id)sender
{
    [self.navigationController pushViewController:[[MedicalConditions alloc] init] animated:TRUE];
}

//TODO: should this live here or inside the  NFNNutrientLevelView?
-(void) warningTapped: (id) sender
{
    //Get the superview from this button -> this is our NFNNutrientLevelView cell
	NFNNutrientLevelView *owningCell = (NFNNutrientLevelView*)[sender superview];
    
    WarningState *warning = owningCell.warningState;
    
    NSString * oneMealOrToday = ([warning.violatedLimitType isEqualToString:kDAILY]) ? @"today" : @"this meal";
    
    
    NSString *warningTitle = [Nutrient friendlyTooMuchLanguageForNutrientNo: owningCell.nutrientNo];
    NSString *warningText = [NSString stringWithFormat:@"That's %@ for %@.",  warningTitle, oneMealOrToday];
    
    //uppercase first chat for title
    
    warningTitle = [warningTitle stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[warningTitle substringToIndex:1] uppercaseString]];
//    if (owningCell.warningState.warningSeverity isEqualToString:kRED_WARNING)
//    {
//        warningText = [NSString stringWithFormat:@" %@ %@", owningCell.warningState.nutrientName];
//    }
//    else
//    {
//        warningText = [NSString stringWithFormat:@"You are %@ %@", owningCell.warningState.nutrientName];    
//    }
    [UIAlertView alertViewWithTitle:[NSString stringWithFormat:@"%@", warningTitle]
                            message:warningText
                  cancelButtonTitle:@"Ok" 
                  otherButtonTitles:[NSArray arrayWithObjects: nil]
                          onDismiss:^(int buttonIndex)
                          {
         
                          }
                          onCancel:^()
                          {
         
                          }
                ];
    
    
	//From the cell get its index path.
    //	NSIndexPath *pathToCell = [nutrientTableView indexPathForCell:owningCell];
    
    //Do something with our path
}





#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of nutrients for our daily limits
    return [[userConsumedNutrientLevelsAndLimits trackedNutrientNumbers] count] ;
}

-(UIView *) footer{
    if(nutrientTableFooterView) return nutrientTableFooterView;
    
    //    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NFNFoodTableCell" owner:nil options:nil];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NutrientLevelsFooter" owner:nil options:nil];
    
    for(id currentObject in topLevelObjects)
    {
        if([currentObject isKindOfClass:[UIView class]])
        {
            nutrientTableFooterView = currentObject;            
            break;
        }
    }

     
    return nutrientTableFooterView;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return [self footer];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    UIView *footer = [self footer];
//    
//    return (footer==nil) ? 0 : [self footer].frame.size.height;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *nutrientNumber = [[userConsumedNutrientLevelsAndLimits trackedNutrientNumbers] objectAtIndex:indexPath.row];
    
    // See if there's an existing cell we can reuse
    NFNNutrientLevelView *cell = [progressViews objectForKey:nutrientNumber];
    
    if (cell == nil) 
    {
        // No cell to reuse => create a new one
        
        // find out what our max for this nutrient should be
        UserDailyLimits *dailyLimits = userConsumedNutrientLevelsAndLimits.dailyLimits;
        
        cell = [NFNNutrientLevelView viewForNutrientNo:nutrientNumber andLimits:dailyLimits];
        
        [progressViews setObject:cell forKey:nutrientNumber];
        
    }
    
    cell.warning.hidden = YES;
    //find the daily amount for the current nutrient
    NutrientAmount *currentNutrientAmount = [userConsumedNutrientLevelsAndLimits nutrientConsumedAmountForNutrientNumber:nutrientNumber];
    // grab the current meal
    Meal *currentMeal = [Meal sharedInstance];
    
    // Customize cell
    NFNNutrientLevelView *customProgress = (NFNNutrientLevelView *)cell;
    // If the current meal has values, uses those in the nutrient totals with the daily amounts
    
    
    
    // progress should be the daily total for this nutrient
    // This is how much the user has already eaten prior to current meal
    float dailyProgress = currentNutrientAmount.quantity;
    [customProgress.progressView setProgressWithActualValue:dailyProgress animated:TRUE];
    
    NutrientAmount *currentMealNutrientAmount = [[Meal sharedInstance] nutrientAmountForNutrientNumber:nutrientNumber];
    // transparent progress should come from the meal
    // This is what the user will potentially add to the daily total once the current meal is saved
    if (currentMeal.mealType == NOT_SET) //we probably just reset the meal because we saved or cancelled
        [customProgress.progressView setTransparentProgressWithActualValue:currentMealNutrientAmount.quantity animated:FALSE];
    else
        [customProgress.progressView setTransparentProgressWithActualValue:currentMealNutrientAmount.quantity animated:TRUE];
    
    // color according to progress 
    //[self setColorsForProgressView:customProgress forProgress:dailyProgress andTotalProgress:currentMealNutrientAmount.quantity];
    [cell setColorsAndWarningsWithTarget:self andSelector:@selector(warningTapped:)];
    
    
    //    NSLog(@"animateBars- dailyProgress for %@ is %f. Tranny progress value is: %f Max value is: %f", nutrientNumber, dailyProgress, currentMealNutrientAmount.quantity, customProgress.progressView.maxValue );
        
    return cell;
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(nutrientLevelRowHeight) return nutrientLevelRowHeight;
    // get a cell, find out the height it wants to be and use that
    nutrientLevelRowHeight = [NFNNutrientLevelView nutrientLevelBlankView].bounds.size.height;
    //    NSLog(@"cell height deteremined: %f", nutrientLevelRowHeight );
    nutrientLevelRowHeight = nutrientLevelRowHeight > 0 ? nutrientLevelRowHeight : 30;
    return nutrientLevelRowHeight;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end