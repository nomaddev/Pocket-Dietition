//
//  NFNFraction.h
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/14/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFNNumber : NSObject<NSCopying>

@property (nonatomic, unsafe_unretained) NSInteger integer;
@property (nonatomic, unsafe_unretained) NSInteger numerator;
@property (nonatomic, unsafe_unretained) NSInteger denominator;

- (id)initWithInteger:(NSInteger)parameterInteger numerator:(NSInteger) parameterNumerator denominator:(NSInteger) parameterDenominator;
-(NSString *) valueAsString;
-(float) valueAsFloat;
-(NSNumber*) valueAsNSNumber;
@end
