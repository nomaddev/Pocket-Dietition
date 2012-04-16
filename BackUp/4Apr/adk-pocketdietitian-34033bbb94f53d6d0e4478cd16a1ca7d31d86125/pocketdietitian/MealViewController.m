//
//  MealViewController.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/1/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "MealViewController.h"

#import "SearchFoodViewController.h"
#import "MealTypeController.h"
#import "Meal.h"
#import "MealPortion.h"
#import "Food.h"
#import "FoodAmountViewController.h"
#import "NFNFoodTableCell.h"
#import "FoodUnitWeight.h"
#import "NFNNumber.h"
#import "UserConsumedNutrientLevelsAndLimits.h"
#import "AppDelegate.h"

@implementation MealViewController
@synthesize mealPortionTableView;
@synthesize mealType;

typedef enum mealPortionSections{ MEAL_PORTION_SECTION, ADD_MORE_FOOD_SECTION } kMealPortionTableViewSection;

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
    //we do this because ptherwise the downward animation from the home screen looks weird
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    // make sure we have the user nutrient levels
    userNutrientLevels = [[self appDelegate] userConsumedNutrientLevelsForToday];
    
    // listen for meal type change
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didUpdateMeal:) name:NOTIFICATION_MEAL_TYPE_CHANGE object:nil];
    // listen for meal portion change
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didUpdateMeal:) name:NOTIFICATION_MEAL_MEAL_PORTION_CHANGE object:nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.navigationController setNavigationBarHidden:TRUE];
    self.navigationItem.titleView = mealType;
    
    // add the cancel and save buttons
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveMeal)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelMeal)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    if ([Meal sharedInstance].mealType == NOT_SET)
    {
        //pick logical next meal
        MealType newMealType = [Meal nextMealType];
        [[Meal sharedInstance] setMealType: newMealType];
        
        //start them off at the meal selector
        //[ self mealTypeTapped:nil];
    }
    
    [mealPortionTableView setEditing:TRUE];
}

- (void) didUpdateMeal:(NSNotification *) notification{
//    [self updateMealView];      ----------------------------- Commented By Tarak
}

-(void) updateMealView{
    if (![Meal sharedInstance].mealType != NOT_SET)
    {
        [mealType setTitle:[Meal nameForMealType:[Meal sharedInstance].mealType ] forState:UIControlStateNormal];
    }
    [mealPortionTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:ADD_MORE_FOOD_SECTION];
    [mealPortionTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateMealView];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [self setMealType:nil];
    [self setMealPortionTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dismissMealBuilder
{
    [self.navigationController.view removeFromSuperview];
}

-(void)saveMeal
{
    Meal *meal = [Meal sharedInstance];
    // save the nutrient values to the daily totals
    for(NSString *trackedNutrientNumber in [userNutrientLevels trackedNutrientNumbers]){
        NutrientAmount *mealAmountForNutrient = [meal nutrientAmountForNutrientNumber:trackedNutrientNumber];
        [userNutrientLevels addNutrientAmount:mealAmountForNutrient toNutrientNumber:trackedNutrientNumber];
    }
    [Meal rememberLastMeal:meal.mealType];
    [meal reset];
    [self dismissMealBuilder];
}

-(void)cancelMeal
{
    [[Meal sharedInstance] reset];
    [self dismissMealBuilder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)addFoodTapped
{
    [self.navigationController pushViewController:[[SearchFoodViewController alloc] init] animated:TRUE];
}
- (IBAction)mealTypeTapped:(id)sender 
{
    [self.navigationController pushViewController:[[MealTypeController alloc]init] animated:TRUE];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == ADD_MORE_FOOD_SECTION){
        return 1;
    }
    
    int numberOfRows = [[Meal sharedInstance] numberOfMealPortions];
    NSLog(@"Number of MealPortions: %d", numberOfRows);
    return numberOfRows;

    
}
- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath {
    int section = indexPath.section;
//    int row = indexPath.row;
    if (tableView.editing && section == ADD_MORE_FOOD_SECTION) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==ADD_MORE_FOOD_SECTION)
    {
        [self addFoodTapped];
    }
    else
    {
        //deleting
        NSLog(@"delete food at %d", [indexPath row]);
        
        [[Meal sharedInstance] removeMealPortionAtIndex:[indexPath row]];
        [self updateMealView];
    }
}

- (NFNFoodTableCell*) tableCell{
    NFNFoodTableCell *cell = nil;
    
//    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NFNFoodTableCell" owner:nil options:nil];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NFNFoodTableCell" owner:nil options:nil];
    for(id currentObject in topLevelObjects)
    {
        if([currentObject isKindOfClass:[NFNFoodTableCell class]])
        {
            cell = (NFNFoodTableCell *)currentObject;
            break;
        }
    }

    return  cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == ADD_MORE_FOOD_SECTION)
    {
        // should only have 1 row in the "add more food" section
        if([indexPath row] > 0 ) return nil;
        UITableViewCell *cellView =  [[UITableViewCell alloc] init];
        // selection style set to None to prevent "Add a food" from being highlighted on return
        [cellView setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cellView.textLabel setText:@"Add a Food"];
        
        //change the look of the cell view - make it slighly transparent
        
        // make the text label's background invisible so we only need to adjust the 
        // cellview's background color
        cellView.textLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
        float cellViewAlpha = 0.85f;
        cellView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:cellViewAlpha];
//        cellView.textLabel.textColor = 
//        [UIColor colorWithWhite:0 alpha:cellViewAlpha];
        //[UIColor colorWithRed:50.0f/255 green:79.0f/255 blue:133.0f/255 alpha:cellViewAlpha];
        
        
        //also add a add button (plus button) as an accessory view
        UIButton *contactAddButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        [contactAddButton setAlpha:cellViewAlpha];
        [contactAddButton setUserInteractionEnabled:FALSE];
        cellView.accessoryView = contactAddButton;
        
//        [cellView setEditing:FALSE];
//        [cellView setEditingAccessoryType: UITableViewCellAccessoryNone];
//        cellView.accessoryType = UITableViewCellAccessoryNone;
        
        //cellView.imageView.image = [UIImage imageNamed:@"addButtonImage.png"];
        
        return cellView;
    }
    
    NSUInteger row = [indexPath row];
    MealPortion *mealPortion = [[Meal sharedInstance] mealPortionAtIndex: row ];
    if(!mealPortion) return nil;
    
    //Display the food description
    NFNFoodTableCell *cellView = [self tableCell];
    //[[UITableViewCell alloc] init];
    cellView.foodLabel.text = mealPortion.food.descriptionLong;
    cellView.unitLabel.text = [ NSString stringWithFormat:@"%@ %@", [mealPortion.quantity valueAsString], mealPortion.foodUnitWeight.unitName] ;
    //[cellView.textLabel setText:mealPortion.food.descriptionLong];
    
    NSLog(@"cellview is null? %d", (cellView == nil) );
    return cellView;
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return [indexPath section] > 0 ? 34 : 44;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    if(section == ADD_MORE_FOOD_SECTION)
    {
        // send the user off to add more food to the meal
        // we dont care about the row when the section is add more food
        // since there should only be one item in that section
        [self addFoodTapped];
        return;
    }
    
    MealPortion *mealPortion = [[Meal sharedInstance] mealPortionAtIndex: row ];
    if(!mealPortion) return ;

    // let the user edit the quantity for the food
    FoodAmountViewController *foodAmountVC = [[FoodAmountViewController alloc] initWithMealPortion:mealPortion];
    [self.navigationController pushViewController:foodAmountVC animated:TRUE];
    
}
@end
