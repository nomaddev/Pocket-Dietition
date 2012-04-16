//
//  PersonalInformation.h
//  pocketdietitian
//
//  Created by hardik on 4/3/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInformation : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    IBOutlet UITableView *tableGender;
    IBOutlet UITableView *tableActivityLevel;
    
    NSMutableArray *arrGender;
    NSMutableArray *arrActivityLevel;
    
    IBOutlet UITextField *txtHeight;
    IBOutlet UITextField *txtWeight;
    IBOutlet UITextField *txtAge;
    IBOutlet UITextField *txtGender;
    IBOutlet UITextField *txtActivityLevel;
    
    IBOutlet UIScrollView *scrollView;
    CGPoint svos;
    
}
@property(nonatomic, retain) UIScrollView *scrollView;

@property(nonatomic, retain) NSMutableArray *arrGender;
@property(nonatomic, retain) NSMutableArray *arrActivityLevel;

-(IBAction)btnDropdownClicked:(id)sender;

@end
