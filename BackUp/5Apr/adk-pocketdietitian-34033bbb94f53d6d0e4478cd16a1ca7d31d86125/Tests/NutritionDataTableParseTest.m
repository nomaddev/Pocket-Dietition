//
//  NutritionDataTableParseTest.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/27/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h> 
#import "USDATableParser.h"
#import "USDATableRow.h"

@interface NutritionDataTableParseTest : GHTestCase 

@end

@implementation NutritionDataTableParseTest

NSString *filePathFD_GROUP;

-(void) setUp
{
    filePathFD_GROUP = [[NSBundle mainBundle] pathForResource:@"NUT_DATA" ofType:@"txt" ];
}

-(void) tearDown
{
}


-(void) testNumberForColumn{
    USDATableParser *tableParser = [[USDATableParser alloc] initWithFilePath:filePathFD_GROUP];
    USDATableRow *usdaRow = [tableParser readDatabaseRow];
    
    NSNumber *result = [usdaRow numberForColumn:USDA_NUT_DATA_COL__NUTR_VAL];
    GHAssertNotNil(result, @"Nutrient value was nil");
    
    GHAssertEquals([result doubleValue], 0.85, @"Nutrient valued from first row did not match %d for some reason. ", 0.85);
}

@end
