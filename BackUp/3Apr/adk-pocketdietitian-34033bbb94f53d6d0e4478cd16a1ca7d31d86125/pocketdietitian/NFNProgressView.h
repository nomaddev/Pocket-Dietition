//
//  NFNProgressView.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/16/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFNProgressView : UIProgressView
{
@private 
    float targetTempProgress;
    int currentStep;
    
    UIImageView *bgImg;
    UIImageView *tranFillImg;
    UIImageView *fillImg;
    
    BOOL animatingTran;
    
}

typedef enum barColorEnum {
    Blue = 0,
    Yellow = 1,
    Red = 2
} BarColor;

@property (nonatomic) BarColor transparentSectionColor;
@property (nonatomic) BarColor filledSectionColor;

@property (nonatomic) float transparentProgress;

// The upper limit for the progress bar
@property (nonatomic) float maxValue;

-(void) setTransparentProgressWithActualValue:(float)parameterProgressValue animated:(BOOL) animated;
-(void) setProgressWithActualValue:(float)parameterProgressValue animated:(BOOL) animated;
-(void) setTransparentProgress:(float)transparentProgress animated:(BOOL) animated;
-(void) setProgress:(float)progress animated:(BOOL) animated;
@end
