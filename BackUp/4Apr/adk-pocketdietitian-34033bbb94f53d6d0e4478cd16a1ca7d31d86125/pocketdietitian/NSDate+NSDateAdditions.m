//
//  NSDate+NSDateAdditions.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 3/1/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NSDate+NSDateAdditions.h"

@implementation NSDate (NSDateAdditions)

-(NSDate *) startOfDay {
    NSCalendar* currentCalendar  = [NSCalendar currentCalendar];
    NSDateComponents* components = [currentCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit 
                                                      fromDate:self];
    // start of the day
    [components setHour: 0];
    [components setMinute: 0];
    [components setSecond: 0];
    return [currentCalendar dateFromComponents:components];

}

-(NSDate *) endOfDay {
    
    NSCalendar* currentCalendar  = [NSCalendar currentCalendar];
    NSDateComponents* components = [currentCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit 
                                                      fromDate:self];
    // end of the day
    [components setHour: 23];
    [components setMinute: 59];
    [components setSecond: 59];
    return [currentCalendar dateFromComponents:components];
}


@end
