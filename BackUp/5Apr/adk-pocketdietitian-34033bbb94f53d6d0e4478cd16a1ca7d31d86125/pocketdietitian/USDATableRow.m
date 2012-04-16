//
//  USDANutritionDbLineParser.m
//  USDADataParser
//
//  Created by Rafael Santiago, Jr. on 1/26/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "USDATableRow.h"
@interface USDATableRow()
-(id) extractFieldData:(NSString*)fieldToken;
@end

@implementation USDATableRow

-(void) loadFromLine:(NSString*)line{
    /* NOTE:
     ^^ = null
     ~~ = empty string (blank)
     */
    
    //split the line into columns; split on ^
    columns = [[line componentsSeparatedByString:@"^"] mutableCopy];
    
    for(int i=0; i < [columns count]; i++){
        NSString* result = [self extractFieldData:[columns objectAtIndex:i]];
        [columns replaceObjectAtIndex:i withObject:result];
    }
       
}

-(id) extractFieldData:(NSString*)fieldToken{
    // check if it's meant to be null
    if( [fieldToken length] == 0 ){
        return [NSNull null];
    }
    
    // check if field is meant to be blank
    if( [fieldToken isEqualToString:@"~~"]){
        return @"";
    }
    
    // grab the field data. String data is 
    // enclosed in ~~
    NSArray *tokenizedField = [fieldToken componentsSeparatedByString:@"~"];
    if([tokenizedField count] == 1){
        // it was non-string data
        return [tokenizedField objectAtIndex:0];
    }
    
    // return the string that was enclosed in ~~
    return [tokenizedField objectAtIndex:1];
    
}

-(NSUInteger) count {
    if(columns == nil){
        return (NSUInteger) 0;
    }
    
    return [columns count];
}

-(NSString*) objectAtIndex:(NSUInteger)index{
    //Should this return nil versus NSNull on null values?
    return [columns objectAtIndex:index];
}



- (NSString *) stringForColumn:(USDATableColumns) column
{
    return [self objectAtIndex:column];
}

-(NSNumber *) numberForColumn:(USDATableColumns) column
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    return [f numberFromString:[self objectAtIndex:column]];
}


@end
