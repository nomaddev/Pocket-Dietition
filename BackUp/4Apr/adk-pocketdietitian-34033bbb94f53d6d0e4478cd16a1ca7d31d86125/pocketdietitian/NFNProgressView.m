//
//  NFNProgressView.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/14/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

// NFNProgressView.m

#define kNFNProgressViewFillOffsetX 0
#define kNFNProgressViewFillOffsetTopY 0
#define kNFNProgressViewFillOffsetBottomY 0
//#define kNFNProgressViewAnimationSpeedPxPerSec 100



#import "NFNProgressView.h"


@interface NFNProgressView (PrivateMethods)

-(UIImage *) fillImageForColor:(BarColor) color;
-(void) setTransparentSectionColor:(BarColor)transparentSectionColor;
- (void) logRect:(CGRect)rect withName:(NSString*)name;
-(int) maxWidth;
-(int) curProgressWidth;
-(CGRect) transparentFillRectForValue:(float) value;
-(void) initViews;
@end


@implementation NFNProgressView

@synthesize transparentProgress = _transparentProgress;
@synthesize transparentSectionColor = _transparentSectionColor;
@synthesize filledSectionColor = _filledSectionColor;
@synthesize maxValue;

//'global' var
CGSize backgroundStretchPoints = {8, 9}, fillStretchPoints = {8, 9};

-(UIImage *) fillImageForColor:(BarColor) color
{
    NSString *fillImageName;
    
    switch (color) {
        case Red:
            fillImageName = @"progress-bar-fill-red.png";
            break;
        case Yellow:
            fillImageName = @"progress-bar-fill-yellow.png";
            break; 
        case Blue:
        default:
            fillImageName = @"progress-bar-fill.png";
            break;
    }
    return [[UIImage imageNamed:fillImageName] stretchableImageWithLeftCapWidth:fillStretchPoints.width 
                topCapHeight:fillStretchPoints.height];  
    
}


-(void) setTransparentSectionColor:(BarColor)color
{
    _transparentSectionColor = color;
    
    //update image
    tranFillImg.image = [self fillImageForColor:_transparentSectionColor];
    [self setNeedsDisplay];
    
}
-(void) setFilledSectionColor:(BarColor)color
{
     _filledSectionColor = color;
    
    //update image
    fillImg.image = [self fillImageForColor:_filledSectionColor];
    [self setNeedsDisplay];
    
}

- (void) logRect:(CGRect)rect withName:(NSString*)name
{
    NSLog(@"== %@ == x: %f, y: %f, width: %f, height: %f", name, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

-(int) maxWidth
{
    // Compute the max width in pixels for the fill.  Max width being how
    // wide the fill should be at 100% progress.
    return self.frame.size.width - (2 * kNFNProgressViewFillOffsetX);
}
-(int) curProgressWidth
{
    // Compute the width for the current progress value, 0.0 - 1.0 corresponding 
    // to 0% and 100% respectively.
    return floor([self progress] * [self maxWidth]);
}

-(CGRect) transparentFillRectForValue:(float) value 
{
    int curWidth = [self curProgressWidth];
    int maxWidth = [self maxWidth];
    
//    NSLog(@"curW: %d", curWidth);
//    NSLog(@"maxWidth: %d", maxWidth);
    
    //TODO: calculate actual transparent piece width
    NSInteger transparentWidth = floor(value * maxWidth);
    
    //limit to 100%
    if (transparentWidth + curWidth > maxWidth) 
        transparentWidth = maxWidth - curWidth;
    
    int overlap = 0;
    
    //if we have the current bar, "tuck" the beginning of the transparent bar underneath it
    if (curWidth>0) 
    {
        overlap = fillStretchPoints.width;   
        
        if (overlap>curWidth) 
            overlap = curWidth;
        //don't add overlap if no transparent progress (nothign to tuck)
        if (value==0) 
            overlap = 0;
        
    }
    CGRect rect = self.frame;
    return CGRectMake(kNFNProgressViewFillOffsetX + curWidth - overlap, //
                      kNFNProgressViewFillOffsetTopY,
                      transparentWidth + overlap,
                      rect.size.height - kNFNProgressViewFillOffsetBottomY);
}

-(void) initViews
{
//    NSLog(@"initViews before bgImg check");
    if (bgImg != nil) return;
    
//    NSLog(@"initViews");
    // Initialize the stretchable images.
    UIImage *background = [[UIImage imageNamed:@"progress-bar-bg.png"] stretchableImageWithLeftCapWidth:backgroundStretchPoints.width 
                                                                                           topCapHeight:backgroundStretchPoints.height];
 
    bgImg = [[UIImageView alloc] initWithImage:background];
    
    tranFillImg = [[UIImageView alloc] initWithImage:[self fillImageForColor:_transparentSectionColor]];
    
    fillImg = [[UIImageView alloc] initWithImage:[self fillImageForColor:_filledSectionColor]];
    
    [tranFillImg setAlpha:.4];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self addSubview:bgImg];
    [self addSubview:tranFillImg];
    [self addSubview:fillImg];
    
}

-(void) setTransparentProgressWithActualValue:(float)parameterProgressValue animated:(BOOL) animated{
    if(!self.maxValue) return;
    
    float progress = parameterProgressValue/self.maxValue;
    [self setTransparentProgress:progress animated:animated];
}

-(void) setProgressWithActualValue:(float)parameterProgressValue animated:(BOOL) animated{
    if(!self.maxValue) return;
    
    float progress = parameterProgressValue/self.maxValue;
    [self setProgress:progress animated:animated];
}

//--------------
-(void) setTransparentProgress:(float)transparentProgress
{
    [self setTransparentProgress:transparentProgress animated:FALSE];
}
-(void) setProgress:(float)progress animated:(BOOL) animated;
{
    //TODO: fix this so it animates as well
    [self setProgress:progress];
    [self setNeedsDisplay]; //mark for redraw
}

-(void) setTransparentProgress:(float)transparentProgress animated:(BOOL) animated
{
    if (transparentProgress<0)
        transparentProgress = 0;
    
    if (!animated)
    {
        //NSLog(@"settransparentProgress: %f", transparentProgress);
        _transparentProgress = transparentProgress;
        [self setNeedsDisplay]; //mark for redraw
    }
    else
    {
        
//        NSLog(@"setTransparentProgress animated %f", transparentProgress);
        //not sure why we had to do this - the starting height was being reported as 15, instead of 20.
        //this resets it to 20:
        tranFillImg.frame = [self transparentFillRectForValue:_transparentProgress];
        
        CGRect targetFrame =  [self transparentFillRectForValue:transparentProgress];
        //[self logRect:targetFrame withName:@"TARGET"];
        animatingTran = TRUE;
        _transparentProgress = transparentProgress; //commit the value change
        [UIView animateWithDuration: .5
                              delay:0
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                              
                             tranFillImg.frame = targetFrame;
                         }
                         completion:^(BOOL finished){
                             animatingTran = FALSE;
                             
                             
                         }];
    }
    
}



- (id)init;
{
    if (self = [super init]) 
    {
        animatingTran = FALSE;
        //[self logRect:frame withName:@"INIT"];
        
        [self initViews];
        
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder;
{
    if (self = [super initWithCoder:aDecoder]) 
    {
        animatingTran = FALSE;
        //[self logRect:frame withName:@"INIT"];
        
        [self initViews];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect 
{
    //[self logRect:rect withName:@"DRAWRECT"];
    
    //[self logRect:self.frame withName:@"OWNFRAME"];
    
    // Create the rectangle for our fill image accounting for the position offsets,
    // 1 in the X direction and 1, 3 on the top and bottom for the Y.
    CGRect fillRect = CGRectMake(rect.origin.x + kNFNProgressViewFillOffsetX,
                                 rect.origin.y + kNFNProgressViewFillOffsetTopY,
                                 [self curProgressWidth],
                                 rect.size.height - kNFNProgressViewFillOffsetBottomY);
    
    //NSLog(@"drawRect  w: %f h:%f", rect.size.width, rect.size.height);
    bgImg.frame = rect;
    
    if (!animatingTran)
        tranFillImg.frame = [self transparentFillRectForValue: [self transparentProgress]];
    
//     NSLog(@"== AFTER DRAW == x: %f, y: %f, width: %f, height: %f", tranFillImg.frame.origin.x, tranFillImg.frame.origin.y, tranFillImg.frame.size.width, tranFillImg.frame.size.height);
    
    fillImg.frame = fillRect;
    
    
}


@end