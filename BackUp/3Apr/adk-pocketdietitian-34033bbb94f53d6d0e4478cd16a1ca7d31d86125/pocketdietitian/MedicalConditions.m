//
//  MedicalConditions.m
//  pocketdietitian
//
//  Created by hardik on 4/3/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "MedicalConditions.h"
#import "PersonalInformation.h"

@implementation MedicalConditions

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

-(IBAction)btnConditionChecked:(id)sender
{
    UIButton *btn = (UIButton*)sender; 
    
    switch (btn.tag)
    {
        case 0: 
        {
            [btnCKD setImage:[UIImage imageNamed:@"check_selected.png"] forState:UIControlStateNormal];
            [btnESRD setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            
            NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
            [preferences setObject:@"YES" forKey:@"CKD"];
            [preferences synchronize];
            
            NSUserDefaults *preferences1 = [NSUserDefaults standardUserDefaults];
            [preferences1 setObject:@"NO" forKey:@"ESRD"];
            [preferences1 synchronize];
            
            break;
        }
        case 1:
        {
            [btnCKD setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            [btnESRD setImage:[UIImage imageNamed:@"check_selected.png"] forState:UIControlStateNormal];
            
            NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
            [preferences setObject:@"YES" forKey:@"ESRD"];
            [preferences synchronize];
            
            NSUserDefaults *preferences1 = [NSUserDefaults standardUserDefaults];
            [preferences1 setObject:@"NO" forKey:@"CKD"];
            [preferences1 synchronize];       
            
            break; 
        }
        case 2: 
            if (btnDiabetes.selected)
            {
                [btnDiabetes setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateSelected];
                
                [btnDiabetes setSelected:NO];
                
                NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                [preferences setObject:@"NO" forKey:@"Diabetes"];
                [preferences synchronize];
            }
            else
            {
                [btnDiabetes setImage:[UIImage imageNamed:@"check_selected.png"] forState:UIControlStateSelected];
                
                [btnDiabetes setSelected:YES];
                
                NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                [preferences setObject:@"YES" forKey:@"Diabetes"];
                [preferences synchronize];
            }
            break; 
        
        case 3:
            if (btnHypertension.selected)
            {
                [btnHypertension setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateSelected];
                
                [btnHypertension setSelected:NO];
                
                NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                [preferences setObject:@"NO" forKey:@"Hypertension"];
                [preferences synchronize];
            }
            else
            {
                [btnHypertension setImage:[UIImage imageNamed:@"check_selected.png"] forState:UIControlStateSelected];
                
                [btnHypertension setSelected:YES];
                
                NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                [preferences setObject:@"YES" forKey:@"Hypertension"];
                [preferences synchronize];
            }

            break; 
        
        case 4: 
            if (btnHC.selected)
            {
                [btnHC setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateSelected];
                
                [btnHC setSelected:NO];
                
                NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                [preferences setObject:@"NO" forKey:@"HighCholesterol"];
                [preferences synchronize];
            }
            else
            {
                [btnHC setImage:[UIImage imageNamed:@"check_selected.png"] forState:UIControlStateSelected];
                
                [btnHC setSelected:YES];
                
                NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
                [preferences setObject:@"YES" forKey:@"HighCholesterol"];
                [preferences synchronize];
            }
            
            break; 
        
        case 5:
            [self.navigationController pushViewController:[[PersonalInformation alloc] init] animated:TRUE];
        
            
    }
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
