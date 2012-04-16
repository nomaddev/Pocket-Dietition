//
//  PersonalInformation.m
//  pocketdietitian
//
//  Created by hardik on 4/3/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "PersonalInformation.h"

@implementation PersonalInformation
@synthesize arrGender,arrActivityLevel,scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
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

#pragma mark - User Defined Functions

-(IBAction)btnDropdownClicked:(id)sender
{
    
    arrGender = [[NSMutableArray alloc]init];
    arrActivityLevel = [[NSMutableArray alloc]init];
    
    UIButton *btn = (UIButton*)sender; 
    
    switch (btn.tag)
    {
        case 0: 
            
            arrGender = [[NSMutableArray alloc]initWithObjects:@"Male",@"Female", nil];
            
            tableGender.hidden = FALSE;
            [tableGender reloadData];
            
            return;
        
        case 1:
            
            arrActivityLevel = [[NSMutableArray alloc]initWithObjects:@"Little to no exercise",@"Light exercise (1–3 days per week)",@"Moderate exercise (3–5 days per week)",@"Heavy exercise (6–7 days per week)",@"Very heavy exercise (twice per day, extra heavy workouts)", nil];
            
            tableActivityLevel.hidden = FALSE;
            [tableActivityLevel reloadData];

            return;
            
        case 2:
        {
            NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
            
            [preferences setObject:txtHeight.text forKey:@"Height"];
            [preferences setObject:txtWeight.text forKey:@"Weight"];
            [preferences setObject:txtAge.text forKey:@"Age"];
            [preferences setObject:txtGender.text forKey:@"Gender"];
            [preferences setObject:txtActivityLevel.text forKey:@"ActivityLevel"];
            
            [preferences synchronize];
        }   
    }
    
    
}

#pragma Text Field Delegate Method

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [scrollView setContentOffset:svos animated:YES]; 
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    
    textField.placeholder = @"";
    svos = scrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    
    rc = [textField convertRect:rc toView:scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 160;
    
    [scrollView setContentOffset:pt animated:YES]; 
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
} 

-(void)viewWillAppear:(BOOL)animated
{

    tableActivityLevel.hidden = TRUE;
    tableGender.hidden = TRUE;
    
    scrollView.contentSize = CGSizeMake(320,550);
    CGPoint topOffset = CGPointMake(0,0);
    [scrollView setContentOffset:topOffset animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TableView Delegate Methods

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableGender)
    {
        return [arrGender count];
    }
    else
        return [arrActivityLevel count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableGender)
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
        cell.textLabel.text = [arrGender objectAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
        cell.textLabel.text = [arrActivityLevel objectAtIndex:indexPath.row];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:16]];
        cell.textLabel.numberOfLines = 3;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        
        return cell;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableGender)
        return 40;
    else
        return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableGender)
    {
        txtGender.text = [arrGender objectAtIndex:indexPath.row];
        tableGender.hidden = TRUE;
    }
    else
    {
        txtActivityLevel.text = [arrActivityLevel objectAtIndex:indexPath.row];
        tableActivityLevel.hidden = TRUE;
    }
}

@end
