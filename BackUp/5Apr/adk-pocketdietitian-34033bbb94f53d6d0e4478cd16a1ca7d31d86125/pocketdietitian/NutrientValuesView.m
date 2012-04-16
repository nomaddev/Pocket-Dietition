//
//  NutrientValuesView.m
//  pocketdietitian
//
//  Created by hardik on 4/4/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NutrientValuesView.h"
#import "SplitRootViewController.h"

@implementation NutrientValuesView

@synthesize strCKD,strESRD,strDiabetes,strHypertesion,strHC,flgSave;

@synthesize calories,carbohydrates,protein,fat,Sodium,Potassium,arrNutrientValues,Fiber,Cholesterol,arrNutrientName;

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

-(void) CalculateUsersNutrientValue
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    
    strCKD = [preferences objectForKey:@"CKD"];
    strESRD = [preferences objectForKey:@"ESRD"];
    strDiabetes = [preferences objectForKey:@"Diabetes"];
    strHypertesion = [preferences objectForKey:@"Hypertension"];
    strHC = [preferences objectForKey:@"HighCholesterol"];
    
    NSLog(@"%@ %@ %@ %@ %@",strCKD,strESRD,strDiabetes,strHypertesion,strHC);
    
    if ([strCKD isEqualToString:@"YES"]) //Calculation for Chronic Kidney Disease 
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        carbohydrates = ((calories * .58) / 4)*1000;
        protein = ((calories * .12) / 4)*1000;
        fat = ((calories * .3) / 9)*1000;
        Sodium = 2000;
        Potassium = 2000;
            
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",nil];
    }
    if ([strESRD isEqualToString:@"YES"]) //Calculation for End Stage Renal Disease 
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        carbohydrates  = ((calories * .52) / 4)*1000;
        protein  = ((calories * .18) / 4)*1000;
        fat  = ((calories * .3) / 9)*1000;
        Sodium = 2000;
        Potassium = 2000; 

        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Phosphorus",nil];
    }
    if ([strDiabetes isEqualToString:@"YES"])//Calculation for Diabetes 
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        carbohydrates = ((calories * .5) / 4)*1000;
        protein = ((calories * .2) / 4)*1000;
        fat = ((calories * .3) / 9)*1000; 
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        
         arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",nil];
    }
    if ([strHypertesion isEqualToString:@"YES"])//Calculation for Hypertension  
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        carbohydrates = ((calories * .55) /4)*1000;
        protein = ((calories * .18) /4)*1000;
        fat = ((calories * .27) /9)*1000;
        Sodium = 2000;
        Potassium = 4700;
        Fiber = 30000;
        Cholesterol = 150;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    if ([strHC isEqualToString:@"YES"])//Calculation for High Cholesterol 
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        carbohydrates = ((calories * .5) / 4)*1000;
        protein = ((calories * .2) / 4)*1000;
        fat = ((calories * .3) / 9)*1000;
        Fiber = 25000;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Fiber",nil];
    }
    
    // Calculation For Chronic Kidney Disease with all other
    
    if ([strCKD isEqualToString:@"YES"] && [strDiabetes isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        
        float ch1 = ((calories * .58) / 4)*1000;
        float ch2 = ((calories * .5) / 4)*1000;
        
        float prot1 = ((calories * .12) / 4)*1000;
        float prot2 = ((calories * .2) / 4)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        fat = ((calories * .3) / 9)*1000;
        Sodium = 2000;
        Potassium = 2000;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",nil];
    }
    if ([strCKD isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
    
        
        calories = 2000;
        
        float ch1 = ((calories * .58) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        
        float prot1 = ((calories * .12) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 30000;
        Cholesterol = 150;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    if ([strCKD isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .58) / 4)*1000;
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .12) / 4)*1000;
        
        fat = ((calories * .3) / 9)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
    
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 30000;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",nil];
    }
    
    // Calculation For End Stage Renal Disease with all other
    
    if ([strESRD isEqualToString:@"YES"] && [strDiabetes isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        
        float ch1 = ((calories * .52) / 4)*1000;
        float ch2 = ((calories * .5) / 4)*1000;
        
        float prot1 = ((calories * .18) / 4)*1000;
        float prot2 = ((calories * .2) / 4)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        fat = ((calories * .3) / 9)*1000;
        Sodium = 2000;
        Potassium = 2000;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",nil];
    }
    if ([strESRD isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"])
    {
        
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        
        calories = 2000;
        
        float ch1 = ((calories * .55) / 4)*1000;
        float ch2 = ((calories * .52) / 4)*1000;
        
        protein = ((calories * .18) /4)*1000;
        
        float fat1 = ((calories * .27) / 9)*1000;
        float fat2 = ((calories * .3) / 9)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
    
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 30000;
        Cholesterol = 150;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    if ([strESRD isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"])
    {
        
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .52) / 4)*1000;
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        
        fat = ((calories * .3) / 9)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 30000;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",nil];
    }

    // Calculation For Diabetes with all other
    
    if ([strDiabetes isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        Sodium = 2000;
        Potassium = 4700;
        Fiber = 30000;
        Cholesterol = 150;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    if ([strDiabetes isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        
        calories = 2000;
        carbohydrates = ((calories * .5) / 4)*1000;
        protein = ((calories * .2) / 4)*1000;
        fat = ((calories * .3) / 9)*1000;        
        Fiber = 25000;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Fiber",nil];
    }
    
    // Calculation For Hypertension with all other
    
    if ([strHypertesion isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        Sodium = 2000;
        Potassium = 4700;
        Fiber = 25000;
        Cholesterol = 150;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    
    // Calculation For Chronic Kidney with diabete and hypertension
    
    if ([strCKD isEqualToString:@"YES"] && [strDiabetes isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        float ch3 = ((calories * .58) / 4)*1000;
        
        carbohydrates = [self smallestOf:ch1 :ch2 :ch3];
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        float prot3 = ((calories * .12) / 4)*1000;
        
        protein = [self smallestOf:prot1 :prot2 :prot3];
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 30000;
        Cholesterol = 150;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    
    // Calculation For Chronic Kidney with hypertension and High cholester
    
    if ([strCKD isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
    
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        float ch3 = ((calories * .58) / 4)*1000;
        
        carbohydrates = [self smallestOf:ch1 :ch2 :ch3];
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        float prot3 = ((calories * .12) / 4)*1000;
        
        protein = [self smallestOf:prot1 :prot2 :prot3];
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 25000;
        Cholesterol = 150;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }

    // Calculation For Chronic Kidney with High cholester and Diabetes
    
    if ([strCKD isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"] && [strDiabetes isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
      
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .58) / 4)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .12) / 4)*1000;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        fat = ((calories * .3) / 9)*1000;
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 25000;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",nil];

    }
    
    // Calculation For End Stage Renal Disease with Diabetes andHypertension
    
    if ([strESRD isEqualToString:@"YES"] && [strDiabetes isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        float ch3 = ((calories * .52) / 4)*1000;
        
        carbohydrates = [self smallestOf:ch1 :ch2 :ch3];
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .12) / 4)*1000;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 30000;
        Cholesterol = 150;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    
    // Calculation For End Stage Renal Disease with Hypertension and High Cholesterol
    
    if ([strESRD isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        float ch3 = ((calories * .52) / 4)*1000;
        
        carbohydrates = [self smallestOf:ch1 :ch2 :ch3];
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 25000;
        Cholesterol = 150;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    
    // Calculation For End Stage Renal Disease with High Cholesterol and diabetes
    
    if ([strESRD isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"] && [strDiabetes isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .52) / 4)*1000;
        
        if (ch1 > ch2) 
            carbohydrates = ch2;
        else
            carbohydrates = ch1;
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        fat = ((calories * .3) / 9)*1000;
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 25000;
        
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
     
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",nil];
    }
    
    
    // Calculation For CKD and Diabetes and High Cholesterol and hypertension
    
    if ([strCKD isEqualToString:@"YES"] && [strDiabetes isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        float ch3 = ((calories * .58) / 4)*1000;
        
        carbohydrates = [self smallestOf:ch1 :ch2 :ch3];
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        float prot3 = ((calories * .12) / 4)*1000;
        
        protein = [self smallestOf:prot1 :prot2 :prot3];
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;

        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 25000;
        Cholesterol = 150;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
    
    // Calculation For ESRD and Diabetes and High Cholesterol and hypertension
    
    if ([strESRD isEqualToString:@"YES"] && [strDiabetes isEqualToString:@"YES"] && [strHypertesion isEqualToString:@"YES"] && [strHC isEqualToString:@"YES"])
    {
        [arrNutrientValues removeAllObjects];
        [arrNutrientName removeAllObjects];
        
        calories = 2000;
        
        float ch1 = ((calories * .5) / 4)*1000;
        float ch2 = ((calories * .55) / 4)*1000;
        float ch3 = ((calories * .52) / 4)*1000;
        
        carbohydrates = [self smallestOf:ch1 :ch2 :ch3];
        
        float prot1 = ((calories * .2) / 4)*1000;
        float prot2 = ((calories * .18) / 4)*1000;
        
        if (prot1 > prot2) 
            protein = prot2;
        else
            protein = prot1;
        
        float fat1 = ((calories * .3) / 9)*1000;
        float fat2 = ((calories * .27) / 9)*1000;
        
        if (fat1 > fat2) 
            fat = fat2;
        else
            fat = fat1;
        
        
        Sodium = 2000;
        Potassium = 2000;
        Fiber = 25000;
        Cholesterol = 150;
        
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",calories]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",carbohydrates]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",protein]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",fat]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Sodium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Potassium]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Fiber]];
        [arrNutrientValues addObject:[NSString stringWithFormat:@"%.1f",Cholesterol]];
        
        arrNutrientName = [[NSMutableArray alloc]initWithObjects:@"Calories",@"Carbohydrates",@"Protein",@"Fat",@"Sodium",@"Potassium",@"Fiber",@"Cholesterol",nil];
    }
}

- (float) smallestOf:(float) a:(float) b: (float) c
{
    float min = a;
    if ( b < min )
        min = b;
    
    if( c < min )
        min = c;
    
    return min;
}

- (void) SaveAction
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    for (int i = 0; i < [arrNutrientName count]; i++)
    {
        [preferences setObject:[arrNutrientValues objectAtIndex:i] forKey:[arrNutrientName objectAtIndex:i]];
    }
    
    [preferences synchronize];
    
    [self.navigationController pushViewController:[[SplitRootViewController alloc] init] animated:TRUE];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    arrNutrientValues = [[NSMutableArray alloc] init];
    arrNutrientName = [[NSMutableArray alloc] init];
    
    [self CalculateUsersNutrientValue];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(SaveAction)];
    
    self.navigationItem.rightBarButtonItem = backButton;
    
    self.title = @"Nutrient Levels";
   
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

#pragma mark - TableView Delegate Methods

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrNutrientValues count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *CellIdentifier = @"Cell";
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UILabel *lblNutrient = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 130, 20)];
        lblNutrient.textAlignment = UITextAlignmentLeft;
        lblNutrient.font = [UIFont boldSystemFontOfSize:16];
        lblNutrient.backgroundColor = [UIColor clearColor];
        lblNutrient.tag = 1;
        
        [cell.contentView addSubview:lblNutrient];

        
        UITextField *txtNutrientValue = [[UITextField alloc] initWithFrame:CGRectMake(150, 5, 90, 30)];
        txtNutrientValue.font = [UIFont fontWithName:@"Arial" size:14];
        txtNutrientValue.textAlignment = UITextAlignmentLeft;
        txtNutrientValue.tag = 2;
        txtNutrientValue.clearButtonMode = UITextFieldViewModeWhileEditing;  
        txtNutrientValue.borderStyle = UITextBorderStyleBezel;
        txtNutrientValue.enabled = FALSE;
        
        [cell.contentView addSubview:txtNutrientValue];
        
        
        UILabel *lblUnit = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 30, 20)];
        lblUnit.textAlignment = UITextAlignmentLeft;
        lblUnit.font = [UIFont boldSystemFontOfSize:16];
        lblUnit.backgroundColor = [UIColor clearColor];
        lblUnit.tag = 3;
        
        [cell.contentView addSubview:lblUnit];

    }
      
    UILabel *lblNutr = (UILabel *) [cell.contentView viewWithTag:1];
    lblNutr.text = [arrNutrientName objectAtIndex:indexPath.row];
    
    
    UITextField *txtValue = (UITextField *)[cell.contentView viewWithTag:2];
    txtValue.text = [arrNutrientValues objectAtIndex:indexPath.row];
    
    UILabel *lblUnit = (UILabel *) [cell.contentView viewWithTag:3];
    lblUnit.text = @"mg"; 
        
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
       
    
}


@end
