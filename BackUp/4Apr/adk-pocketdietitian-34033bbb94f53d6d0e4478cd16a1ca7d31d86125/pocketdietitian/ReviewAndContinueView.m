//
//  ReviewAndContinueView.m
//  pocketdietitian
//
//  Created by hardik on 4/3/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "ReviewAndContinueView.h"
#import "NutrientValuesView.h"
#import "SplitRootViewController.h"

@implementation ReviewAndContinueView

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

-(IBAction)btnClicked:(id)sender
{
    UIButton *btn = (UIButton*)sender; 
    
    switch (btn.tag)
    {
        case 0: 
            
             [self.navigationController pushViewController:[[NutrientValuesView alloc] init] animated:TRUE];
            
            return;
            
        case 1:
            
             [self.navigationController pushViewController:[[SplitRootViewController alloc] init] animated:TRUE];
            
            return;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = FALSE;
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

@end
