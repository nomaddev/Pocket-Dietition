//
//  WarningState.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 3/1/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NFNProgressView.h"

#define kRED_WARNING 2
#define kYELLOW_WARNING 1
#define kNO_WARNING 0

#define kDAILY @"daily"
#define kMEAL @"meal"

//Rules for color change::: for the daily allotment
//green -70%
//yellow 71% 99%
//red 100% above
#define  kYELLOW_THRESHOLD .7
#define  kRED_THRESHOLD .99

@interface WarningState : NSObject
{
    
}

@property (strong) NSString *violatedLimitType;
@property int warningSeverity;

@end
