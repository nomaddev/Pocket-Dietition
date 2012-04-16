//
//  MealTypeController.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/7/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "MealTypeController.h"
#import "Meal.h"
#import "SearchFoodViewController.h"

@implementation MealTypeController
@synthesize mealTypeTableView;

typedef enum mealTypeSection{ BIG_MEAL_SECTION, SNACK_SECTION } kMealTypeSection;

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
    if ([Meal sharedInstance].mealType == NOT_SET)
    {
        NSLog(@"not set");
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelMeal)];
        self.title = @"Pick Meal";
    }
    //we do this because ptherwise the downward animation from the home screen looks weird
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    
    MealType mealType =[[Meal sharedInstance] mealType];
    NSIndexPath *indexPath = nil;
    
    switch( mealType ){
        case BREAKFAST:
        case LUNCH:
        case DINNER:
            indexPath = [NSIndexPath indexPathForRow:mealType inSection:BIG_MEAL_SECTION] ;
            break;
        case SNACK:
            indexPath = [NSIndexPath indexPathForRow:0 inSection:SNACK_SECTION] ;
            break;
        default:
            // dont bother setting anything
            return;
    }
    
    [mealTypeTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom  ];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

-(void)cancelMeal
{
    [self.navigationController.view removeFromSuperview];
    [[Meal sharedInstance] reset];
}

- (void)viewDidUnload
{
    [self setMealTypeTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case BIG_MEAL_SECTION:
            return 3;
        case SNACK_SECTION:
            return 1;
    }
    return 0;
}
- (MealType)mealTypeForIndexPath:(NSIndexPath *)indexPath
{
    //TODO: return and set type
    if ([indexPath section]==BIG_MEAL_SECTION)
        return [indexPath row];
    else
        return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section: %d; row: %d", [indexPath section], [indexPath row]);
    NSLog(@"mt: %d", [self mealTypeForIndexPath:indexPath]);
    
    NSString *meal = [Meal nameForMealType:[self mealTypeForIndexPath:indexPath]];
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    [cell.textLabel setText:meal];
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *) indexPath
{
    if ([Meal sharedInstance].mealType == [self mealTypeForIndexPath:indexPath])
        [cell setSelected:TRUE];
}
*/
#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Meal *meal = [Meal sharedInstance]; 
    meal.mealType = [self mealTypeForIndexPath:indexPath];
    
    // Back to the meal builder
    [self.navigationController popViewControllerAnimated:TRUE];        
}


@end
