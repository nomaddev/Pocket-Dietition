//
//  TermsAndConditionView.m
//  pocketdietitian
//
//  Created by hardik on 4/3/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "TermsAndConditionView.h"
#import "MedicalConditions.h"

@implementation TermsAndConditionView

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

#pragma mark - User Defined

-(IBAction)btnAcceptClicked
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:@"Accepted" forKey:@"TermsAndCondition"];
    [preferences synchronize];
    
    [self.navigationController pushViewController:[[MedicalConditions alloc] init] animated:TRUE];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
