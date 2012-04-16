//
//  FoodAmountViewController.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/31/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
@class Food;
@class MealPortion;
@class FoodUnitWeight;
@class NFNNumber;

@interface FoodAmountViewController : BaseViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
    Food *food;
    float totalGramWeightConsumed;
    NSString *totalAmountDisplay;
    MealPortion *mealPortion;
    // copy of original meal portion in case it needs to be restored
    MealPortion *backupMealPortion;
    
@private NSMutableArray *displayFractions;

    
}
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *lblNutrientResults;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblFoodName;

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *txtAmount;
@property (unsafe_unretained, nonatomic) IBOutlet UIPickerView *pickerView;


-(id) initWithFood:(Food *) theFood;
-(id) initWithMealPortion:(MealPortion *) theMealPortion;

//- (IBAction)rollDice:(id)sender;


@end
