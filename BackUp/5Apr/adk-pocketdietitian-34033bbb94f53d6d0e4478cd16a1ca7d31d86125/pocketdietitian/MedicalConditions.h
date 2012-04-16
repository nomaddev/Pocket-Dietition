//
//  MedicalConditions.h
//  pocketdietitian
//
//  Created by hardik on 4/3/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
// http://developinginthedark.com/posts/iphone-tapku-calendar-markers
// http://itarato.blogspot.in/2011/02/ios-libraries.html

#import <UIKit/UIKit.h>

@interface MedicalConditions : UIViewController
{
    IBOutlet UIButton *btnCKD;
    IBOutlet UIButton *btnESRD;
    IBOutlet UIButton *btnDiabetes;
    IBOutlet UIButton *btnHypertension;
    IBOutlet UIButton *btnHC;
    
}
-(IBAction)btnConditionChecked:(id)sender;

@end
