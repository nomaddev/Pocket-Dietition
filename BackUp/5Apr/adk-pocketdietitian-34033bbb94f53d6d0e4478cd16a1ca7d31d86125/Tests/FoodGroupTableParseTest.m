//
//  FoodGroupTableParserTest.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/27/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//


#import "NFNBaseCoreDataTestCase.h"
#import "USDATableParser.h"
#import "USDATableRow.h"

@interface FoodGroupTableParseTest : NFNBaseCoreDataTestCase {}

@end


@implementation FoodGroupTableParseTest

NSString *filePathFD_GROUP;

-(void) setUp
{
    filePathFD_GROUP = [[NSBundle mainBundle] pathForResource:@"FD_GROUP" ofType:@"txt" ];
}

-(void) tearDown
{
}

-(void) testLoadFile
{
    USDATableParser *tableParser = [[USDATableParser alloc] initWithFilePath:filePathFD_GROUP];
    GHAssertNotNil(tableParser, @"Table parser was nil. Couldn't find %@", filePathFD_GROUP);
}

-(void) testReadRow
{
    USDATableParser *tableParser = [[USDATableParser alloc] initWithFilePath:filePathFD_GROUP];
    USDATableRow *usdaRow = [tableParser readDatabaseRow];
    
    GHAssertNotNil(usdaRow, @"Food group row was nil");
    
}

-(void) testRowHasCode
{
    USDATableParser *tableParser = [[USDATableParser alloc] initWithFilePath:filePathFD_GROUP];
    USDATableRow *usdaRow = [tableParser readDatabaseRow];
    
    GHAssertNotNil([usdaRow stringForColumn:USDA_FD_GROUP_COL__FDGRP_CD], @"Food group code was nil");
    
}

-(void) testRowHasDescription
{
    USDATableParser *tableParser = [[USDATableParser alloc] initWithFilePath:filePathFD_GROUP];
    USDATableRow *usdaRow = [tableParser readDatabaseRow];
    
    GHAssertNotNil([usdaRow stringForColumn:USDA_FD_GROUP_COL__FDGRP_DESC], @"Food group desc was nil");
}

-(void) testReadNextRow
{
    USDATableParser *tableParser = [[USDATableParser alloc] initWithFilePath:filePathFD_GROUP];
    USDATableRow *usdaRow1 = [tableParser readDatabaseRow];
    
    USDATableRow *usdaRow2 = [tableParser readDatabaseRow];
    
       
    GHAssertNotEqualStrings([usdaRow1 stringForColumn:USDA_FD_GROUP_COL__FDGRP_CD], [usdaRow2 stringForColumn:USDA_FD_GROUP_COL__FDGRP_CD], @"codes were equal, row did not advance; 1:%@, 2:%@", [usdaRow1 stringForColumn:USDA_FD_GROUP_COL__FDGRP_CD], [usdaRow2 stringForColumn:USDA_FD_GROUP_COL__FDGRP_CD]);

    
}


@end
