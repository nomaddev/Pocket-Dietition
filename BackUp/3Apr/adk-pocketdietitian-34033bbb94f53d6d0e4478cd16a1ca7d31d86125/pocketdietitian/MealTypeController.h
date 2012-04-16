//
//  MealTypeController.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/7/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "BaseViewController.h"

@interface MealTypeController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UITableView *mealTypeTableView;

@end
