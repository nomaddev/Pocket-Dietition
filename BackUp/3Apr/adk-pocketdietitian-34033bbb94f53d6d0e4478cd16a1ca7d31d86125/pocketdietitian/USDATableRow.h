//
//  USDANutritionDbLineParser.h
//  USDADataParser
//
//  Created by Rafael Santiago, Jr. on 1/26/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//
//  Converts a line in a USDA database table into columns.

#import <Foundation/Foundation.h>

@interface USDATableRow : NSObject{
@private
NSMutableArray* columns;
}

-(void) loadFromLine:(NSString*)line;
-(NSUInteger) count;
-(NSString*) objectAtIndex:(NSUInteger)index;

typedef enum{
    // Food Group data table columns
    USDA_FD_GROUP_COL__FDGRP_CD = 0,
    USDA_FD_GROUP_COL__FDGRP_DESC = 1,
    
    // Nutrition data table columns
    USDA_NUT_DATA_COL__NDB_NO = 0,
    USDA_NUT_DATA_COL__NUTR_NO = 1,
    USDA_NUT_DATA_COL__NUTR_VAL = 2,
    
    
    //Food Unit Weight table columns
    USDA_WEIGHT_COL__MSRE_DESC=3,
    USDA_WEIGHT_COL__GM_WGHT=4,
    USDA_WEIGHT_COL__AMOUNT=2,
    USDA_WEIGHT_COL__NDB_NO=0,
    
    //Food Description table columns
    USDA_FOOD_DES_COL__LONG_DESC=2,
    USDA_FOOD_DES_COL__SHRT_DESC=3,
    USDA_FOOD_DES_COL__COMNAME=4,
    USDA_FOOD_DES_COL__MANUFACNAME=5,
    USDA_FOOD_DES_COL__NDB_NO=0,
    USDA_FOOD_DES_COL__FDGRP_CD=1,
    
    //Nutrient definition
    USDA_NUTR_DEF_COL__NUTRDESC = 3,
    USDA_NUTR_DEF_COL__UNITS = 1,
    USDA_NUTR_DEF_COL__NUTR_NO = 0
    
} USDATableColumns;

- (NSString *) stringForColumn:(USDATableColumns) column;
- (NSNumber *) numberForColumn:(USDATableColumns) column;

@end
