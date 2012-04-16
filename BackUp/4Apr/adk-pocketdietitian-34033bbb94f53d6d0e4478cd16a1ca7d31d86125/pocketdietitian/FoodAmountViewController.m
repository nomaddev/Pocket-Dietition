//
//  FoodAmountViewController.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/31/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "FoodAmountViewController.h"

#import "Food.h"
#import "FoodUnitWeight.h"
#import "FoodNutrientData.h"
#import "Nutrient.h"
#import "AppDelegate.h"
#import "MealPortion.h"
#import "Meal.h"
#import "NFNNumber.h"
#import "UIAlertView+MKBlockAdditions.h"

// private methods for FoodAmountViewController
@interface FoodAmountViewController()
-(void) setupDisplayFractions;
@end 
// ----- End FoodAmountViewController category -----

@implementation FoodAmountViewController

@synthesize lblNutrientResults;
//@synthesize navBar;
@synthesize lblFoodName;
@synthesize txtAmount;
@synthesize pickerView;

typedef enum foodAmountPickerSections { FOOD_AMOUNT_PICKER_WHOLE_NUMBER, FOOD_AMOUNT_PICKER_FRACTION, FOOD_AMOUNT_PICKER_UNIT} NFNFoodAmountPickerSections ;

-(void) setupDisplayFractions{
    int denominators[] = {8,4,3,2};
    displayFractions = [ [NSMutableArray alloc] init]; 
    //Add zero 
    [displayFractions addObject: [[NFNNumber alloc]initWithInteger:0 numerator:0 denominator:1] ];
    
    //add fractions 1/8, 1/4, 1/3, and 1/2
    for(int i=0; i < ( sizeof denominators/sizeof denominators[0]); i++){
        [displayFractions addObject: [[NFNNumber alloc]initWithInteger:0 numerator:1 denominator:denominators[i]] ];
    }
    
    //add fractions 2/3 and 3/4
    [displayFractions addObject: [[NFNNumber alloc]initWithInteger:0 numerator:2 denominator:3] ];
    [displayFractions addObject: [[NFNNumber alloc]initWithInteger:0 numerator:2 denominator:4] ];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        mealPortion = [[MealPortion alloc] init];
        //we're creating a new meal portion, no need to back it up
        backupMealPortion = nil;
        [self setupDisplayFractions];
    }
    return self;
}

-(id) initWithFood:(Food *) theFood
{
    self = [super initWithNibName:@"FoodAmountViewController" bundle:nil];
    if(self){
        
        food = theFood;
        mealPortion = [[MealPortion alloc] init];
        mealPortion.food = theFood;
        //we're creating a new meal portion, no need to back it up
        backupMealPortion = nil;
        [self setupDisplayFractions];
    }
    return self;
}

-(id) initWithMealPortion:(MealPortion *) theMealPortion
{
    self = [super initWithNibName:@"FoodAmountViewController" bundle:nil];
    if(self){
        
        mealPortion = theMealPortion;
        //preserve the portion in case of a restore is needed
        backupMealPortion = [mealPortion copy];
        food = mealPortion.food;
        [self setupDisplayFractions];
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
//    [self rollDice:nil];
    /*
    CGSize pickerSize = [pickerView sizeThatFits:CGSizeZero];
    
    pickerParentView = [[UIView alloc] initWithFrame:CGRectMake(-10.0f, -10.0f, pickerSize.width, pickerSize.height)];
    pickerParentView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
    
    [pickerView removeFromSuperview];
    [pickerParentView addSubview:pickerView];
    [self.view addSubview:pickerParentView];
     */
    
    //pickerView.frame = CGRectMake(0,0, 320, 162);
    
    
    // Set the food chosen to the title
    UIView *oldTitleView = self.navigationItem.titleView;
    NSLog(@"width %f height %f x %f y %f", oldTitleView.frame.size.width, oldTitleView.frame.size.height, oldTitleView.frame.origin.x, oldTitleView.frame.origin.y); 
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 160, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor]; 
    titleLabel.text = food.descriptionLong;
    //titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    // try to get the text to fit as comfortably as possible
    float titleFontSize = [UIFont labelFontSize];
    if([titleLabel.text length] > 25){
        titleFontSize = 10;
        titleLabel.numberOfLines = 3;
    }else if([titleLabel.text length] > 15){
        titleFontSize = 12;
        titleLabel.numberOfLines = 2;
    }
    titleLabel.textAlignment = titleLabel.numberOfLines > 1 ? UITextAlignmentLeft : UITextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:titleFontSize];
        self.navigationItem.titleView = titleLabel;
    
    //[self setTitle:food.descriptionLong];
    
    // add the done and cancel buttons
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(addSelectedFood)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationItem.rightBarButtonItem setEnabled:FALSE];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAndReturnToMeal)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    //TODO refactor into separate method
    // row indexes for the picker
    int fractionalNumberIndex = 0;
    int foodWeightIndex  = 0;
    int wholeNumberIndex = 0;
    
    // Determine the whole number row index
    // since the whole number maps to the index, we can do this
    wholeNumberIndex = [mealPortion quantity].integer;
    
    // determine fraction row index 
    for(int i =0; i< [displayFractions count]; i++){
        NFNNumber *fraction = [displayFractions objectAtIndex:i ];
        if([mealPortion quantity].numerator == fraction.numerator &&
           [mealPortion quantity].denominator == fraction.denominator){
            fractionalNumberIndex = i;
            break;
        }
    }
    
    //determine the food weight's row index 
    if(mealPortion.foodUnitWeight){
        int i = 0;
        for(FoodUnitWeight *unitWeight in [food.unitWeights allObjects]){
            if( [mealPortion.foodUnitWeight.unitName isEqual:unitWeight.unitName] ){
                foodWeightIndex = i;
                break;
            }
            i++;
        }
    }
    
    NSLog(@"+++indexes are: %d %d %d", wholeNumberIndex, fractionalNumberIndex, foodWeightIndex);    
    // update the whole number amount on the picker
    [pickerView selectRow:wholeNumberIndex inComponent:FOOD_AMOUNT_PICKER_WHOLE_NUMBER animated:FALSE];
    // update the fractional number on the picker
    [pickerView selectRow:fractionalNumberIndex inComponent:FOOD_AMOUNT_PICKER_FRACTION animated:FALSE];
    // update the food weight on the picker
    [pickerView selectRow:foodWeightIndex inComponent:FOOD_AMOUNT_PICKER_UNIT animated:FALSE];
    
}

- (void)cancelAndReturnToMeal{
    NSLog(@"cancelAndRerturnToMeal");
    
    // check if we need to replace or outright
    // remove the mealportion
    if(backupMealPortion){
        NSLog(@"Replacing meal portion");
        [[Meal sharedInstance] replaceMealPortion:mealPortion with:backupMealPortion];
    }else{
        NSLog(@"Removing meal portion");
        [[Meal sharedInstance] removeMealPortion:mealPortion];
    }
    [self.navigationController  popToRootViewControllerAnimated:YES];
}

- (void)addFoodAndReturnToMeal
{
    // Meal portions are updated and added everytime the picker
    // is used by the user so all we have to do now is just 
    // pop back to the root
        
    // go back to the meal builder
    [self.navigationController  popToRootViewControllerAnimated:YES];
}

-(void)addSelectedFood
{
    //validate
    if (totalGramWeightConsumed==0)
    {
        [UIAlertView alertViewWithTitle:@"You didn't enter anything." 
                                message:@"Do you want to remove this food from your meal?" 
                      cancelButtonTitle:@"No, let me fix it" 
                      otherButtonTitles:[NSArray arrayWithObjects:@"Yes, remove", nil]
        onDismiss:^(int buttonIndex)
         {
             [self addFoodAndReturnToMeal];
         }
        onCancel:^()
         {
             NSLog(@"Cancelled, stay here and fix");         
         }
         ];
    }
    else if (totalGramWeightConsumed<5)
    {
        [UIAlertView alertViewWithTitle:@"That's not a lot of food." 
                                message:@"Is that what you really meant?" 
                      cancelButtonTitle:@"No, let me fix it" 
                      otherButtonTitles:[NSArray arrayWithObjects:@"Yes, that's correct", nil]
                              onDismiss:^(int buttonIndex)
         {
             [self addFoodAndReturnToMeal];
         }
                               onCancel:^()
         {
             NSLog(@"Cancelled, stay here and fix");         
         }
         ];
    }
    else if (totalGramWeightConsumed>1500)//3 lbs   
    {
        
        [UIAlertView alertViewWithTitle:@"Whoa, whoa, whoa there" 
                                message:[NSString stringWithFormat:@"That's a lot of food. Did you really mean to enter that much?", totalAmountDisplay] 
                      cancelButtonTitle:@"No, let me fix it" 
                      otherButtonTitles:[NSArray arrayWithObjects:@"Yes, that's correct", nil]
                              onDismiss:^(int buttonIndex)
         {
            [self addFoodAndReturnToMeal];
         }
        onCancel:^()
         {
             NSLog(@"Cancelled, stay here and fix");         
         }
         ];
    }    
    else
    {
        [self addFoodAndReturnToMeal];
    }
    
    
   
}

- (void)viewDidUnload
{
    [self setTxtAmount:nil];
    [self setLblFoodName:nil];
    [self setPickerView:nil];
    [self setLblNutrientResults:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/*
- (IBAction)rollDice:(id)sender 
{
    NSFetchRequest * allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:[Food entityName] inManagedObjectContext:[self sharedManagedObjectContext]]];
    
    NSError *error = nil;
    NSArray *items = [[self sharedManagedObjectContext] executeFetchRequest:allItems error:&error];
    
    //TODO: this is not actual desired functionality
    //user should get to actually choose their food item
    int x = arc4random() % [items count];
    NSLog(@"%d", x);
    food = [items objectAtIndex:x];
    lblFoodName.text = food.descriptionLong;
    
    [self.pickerView reloadAllComponents];
    navBar.topItem.title = food.descriptionLong;
//    [self setTitle:food.descriptionLong];

    NSLog(@"title: %@", food.descriptionLong);
}
*/


#pragma mark - UIPickerViewDataSource


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component){
        case FOOD_AMOUNT_PICKER_WHOLE_NUMBER:
            return 100;
        case FOOD_AMOUNT_PICKER_FRACTION :
            return 7;
        case FOOD_AMOUNT_PICKER_UNIT:
            return [food.unitWeights count];
            
    }    
    return 0;
}



#pragma mark - UIPickerViewDelegate

// returns width of column and height of row for each component. 
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    int size = 285;
    switch (component) {
        case FOOD_AMOUNT_PICKER_WHOLE_NUMBER: 
            return size*.25;
        case FOOD_AMOUNT_PICKER_FRACTION:
            return size*.15;
        case FOOD_AMOUNT_PICKER_UNIT: 
            return size*.60;
        
    }
    return 0;
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    
//}

// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse. 
// If you return back a different object, the old one will be released. the view will be centered in the row rect  
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component) {
        case FOOD_AMOUNT_PICKER_WHOLE_NUMBER:
            return row == 0 ? @"" : [NSString stringWithFormat:@"%d",row];
        case FOOD_AMOUNT_PICKER_FRACTION:
            return row == 0 ? @"" : [[displayFractions objectAtIndex:row] valueAsString];
        case FOOD_AMOUNT_PICKER_UNIT:
            return ((FoodUnitWeight *)[[food.unitWeights allObjects] objectAtIndex:row]).unitName;
    }
    
    return nil;
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    
//}

- (void)pickerView:(UIPickerView *)parameterPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"didSelectRow");
    
    int wholeNumberRow = [self.pickerView selectedRowInComponent:FOOD_AMOUNT_PICKER_WHOLE_NUMBER ];
    int fractionRow = [self.pickerView selectedRowInComponent:FOOD_AMOUNT_PICKER_FRACTION ];
    int unitRow = [self.pickerView selectedRowInComponent:FOOD_AMOUNT_PICKER_UNIT ];
    
    // if we changed the wholeNumber component, reset the fractional component to 0
    if(component == FOOD_AMOUNT_PICKER_WHOLE_NUMBER ){
        [parameterPickerView selectRow:0 inComponent:FOOD_AMOUNT_PICKER_FRACTION animated:YES];
        fractionRow = 0;
    }
    
    FoodUnitWeight *foodUnitWeight = [[food.unitWeights allObjects] objectAtIndex:unitRow];
    
    NSLog(@"===============selected fraction row: %d", fractionRow);
    
    // create a copy of the selected fraction so we dont accidentally clobber the values on the one being used for display
    NFNNumber *quantityOfUnitConsumed = [[displayFractions objectAtIndex:fractionRow ] copy];
    quantityOfUnitConsumed.integer = wholeNumberRow;
    
    NSLog(@"===============wholeNumber: %d", quantityOfUnitConsumed.integer);
    NSLog(@"===============fractionalNumber: %d/%d", quantityOfUnitConsumed.numerator, quantityOfUnitConsumed.denominator);
    
    totalGramWeightConsumed = [foodUnitWeight totalGramWeightForAmountConsumed:[ quantityOfUnitConsumed valueAsNSNumber]  ];
    
    //toggle Add button
    [self.navigationItem.rightBarButtonItem setEnabled:totalGramWeightConsumed>0];
    
    NSLog(@"===============totalGramWeightConsumed: %f", totalGramWeightConsumed);
    
    
    //Add the amount consumed and food weight to the meal portion
    mealPortion.foodUnitWeight = foodUnitWeight;
    mealPortion.quantity = quantityOfUnitConsumed;
    [[Meal sharedInstance]addMealPortion:mealPortion];
    
    /*
    lblNutrientResults.text = @"";
    
    NSMutableString *newText = [NSMutableString stringWithString:@""];
    
        for (FoodNutrientData *nutData in food.nutrients) 
    {
        NSLog(@"calculate");
        float nutrientValueConsumed = [nutData nutrientValueForGramAmount:totalGramWeightConsumed];

        NSLog(@"fetch nutrient");
        NSString *nutrientString = [NSString stringWithFormat:@"%@  \t-\t  %f\n", nutData.nutrient.name, nutrientValueConsumed];    
        
        NSLog(@"%@", nutrientString);
        
        NSLog(@"done, append");
        
        [newText appendString:nutrientString];
        NSLog(@"done");
    }
     
    NSLog(@"display");        
    lblNutrientResults.text = newText;
     */
    NSLog(@"done");
    
}

//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
//    
//}

@end
