//
//  NutrientValuesView.h
//  pocketdietitian
//
//  Created by hardik on 4/4/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NutrientValuesView : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *table;
    
    NSString *strCKD;
    NSString *strESRD;
    NSString *strDiabetes;
    NSString *strHypertesion;
    NSString *strHC;
    
    float calories;
    float carbohydrates;
    float protein;
    float fat;
    float Sodium;
    float Potassium;
    float Fiber;
    float Cholesterol;
    
    NSMutableArray *arrNutrientValues;
    NSMutableArray *arrNutrientName;
}
@property (nonatomic, retain) NSString *strCKD;
@property (nonatomic, retain) NSString *strESRD;
@property (nonatomic, retain) NSString *strDiabetes;
@property (nonatomic, retain) NSString *strHypertesion;
@property (nonatomic, retain) NSString *strHC;

@property (nonatomic, readwrite) float calories;
@property (nonatomic, readwrite) float carbohydrates;
@property (nonatomic, readwrite) float protein;
@property (nonatomic, readwrite) float fat;
@property (nonatomic, readwrite) float Sodium;
@property (nonatomic, readwrite) float Potassium;
@property (nonatomic, readwrite) float Fiber;
@property (nonatomic, readwrite) float Cholesterol;

@property (nonatomic, retain) NSMutableArray *arrNutrientValues; 
@property (nonatomic, retain) NSMutableArray *arrNutrientName;

-(void) CalculateUsersNutrientValue;

@end
