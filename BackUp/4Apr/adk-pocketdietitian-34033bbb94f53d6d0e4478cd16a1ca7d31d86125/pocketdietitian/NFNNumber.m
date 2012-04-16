//
//  NFNFraction.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/14/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NFNNumber.h"

@implementation NFNNumber

@synthesize integer;
@synthesize numerator;
@synthesize denominator;

- (id)init {
    self = [super init];
    if (self) {
        integer     = 1;
        numerator   = 1;
        denominator = 1;
    }
    return self;
}

- (id)initWithInteger:(NSInteger)parameterInteger numerator:(NSInteger) parameterNumerator denominator:(NSInteger) parameterDenominator{
    self = [super init];
    if (self) {
        if(!parameterDenominator){
            parameterDenominator = 1;
        }
        integer     = parameterInteger;
        numerator   = parameterNumerator;
        denominator = parameterDenominator;
    }
    return self;
}

-(void) convertToProperFraction{
    NSInteger newInteger = numerator/denominator;
    
    if( newInteger ) {
        //simplify the improper fraction
        numerator = numerator % denominator;
        integer = newInteger;
    }
    
}

-(void) setDenominator: (NSInteger)paramDenominator{
    // don't allow 0 as the denominator, we don't want to end up 
    // dividing by zero
    if(!paramDenominator) return;
    
    denominator = paramDenominator;
}

-(NSString *) valueAsString{
    // if numerator is zero, only show the integer
    if(!numerator){
        return [NSString stringWithFormat:@"%d", integer];
    }
        
    // if integer is zero and we have a numerator, show the fraction
    if(!integer){
        return [NSString stringWithFormat:@"%d/%d", numerator, denominator];
    }
    
    return [NSString stringWithFormat:@"%d %d/%d", integer, numerator, denominator];
    
}

-(float) valueAsFloat{
    return integer + ( ((float)numerator)/denominator  ) ;
}

-(NSNumber*) valueAsNSNumber{
    return [NSNumber numberWithFloat:[self valueAsFloat]];
}

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone{
     return [[[self class] allocWithZone: zone] initWithInteger:integer numerator:numerator denominator:denominator];
    
}
@end
