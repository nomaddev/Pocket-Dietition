//
//  USDADatabaseLoader.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/27/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "USDADatabaseImporter.h"

#import "Food.h"
#import "FoodGroup.h"
#import "Nutrient.h"
#import "FoodUnitWeight.h"
#import "FoodNutrientData.h"

#import "USDATableParser.h"
#import "USDATableRow.h"

#import "Constants.h"

@implementation USDADatabaseImporter


+(BOOL) databaseExists:(NSURL*) storeURL
{
    // Put down default db if it doesn't already exist
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSLog(@"database: %@", [storeURL path]);
    
    if ([fileManager fileExistsAtPath:[storeURL path]]) 
        return TRUE;
    return FALSE;
}

+(void) removePersistentStoreAtUrl:(NSURL*) storeToRemove{
    if(storeToRemove){
        NSLog(@"deleting database at path: %@", storeToRemove );
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtURL:storeToRemove error:NULL];
    }
}

+ (void)saveCoreData:(NSManagedObjectContext *)context
{
    NSLog(@"saving data...");
    
    NSError *error2;
    if (![context save:&error2]) 
    {
        NSLog(@"Whoops, couldn't save: %@", [error2 localizedDescription]);
    }
    else
    {
        NSLog(@"saved after insert");
    }
}
+(bool) isWhitelistedNutrient:(NSString *) nutrientNumber{
    NSArray *whiteList = [[NSArray alloc] initWithObjects:@"307", @"306", @"305", @"203", @"257", @"255", @"208", @"205", @"204", @"291", @"601", nil];
    
    return [whiteList containsObject:nutrientNumber] ;
}

+(void) importDatabase:(NSManagedObjectContext*) context
{
    NSLog(@"importing data...");
    
    
    USDATableParser *usdaParser; 
    
    USDATableRow *row;
    
    NSLog(@"nutrient data");
    /*
     Currently we only care about :
     sodium 307
     potassium 306
     phosphorus 305
     protein 203
     (adjusted protein 257)
     fluids 255
     calories 208
     carbohydrates 205
     fat 204
     Cholesterol 601
     fiber 291
     
     net carbohydrates = carbohydrate - fiber;
     */

    //import the nutrient data from the usda file database table
    @autoreleasepool {
        usdaParser = [[USDATableParser alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"NUT_DATA" ofType:@"txt" ]];
        while(  (row = [usdaParser readDatabaseRow]) ){
            NSString *nutrientNumber = [row stringForColumn:USDA_NUT_DATA_COL__NUTR_NO] ;
            
            if( ![self isWhitelistedNutrient:nutrientNumber] ) continue;
            
            FoodNutrientData *nutrientData = [NSEntityDescription
                                              insertNewObjectForEntityForName:[FoodNutrientData entityName] 
                                              inManagedObjectContext:context];
            //nutrientData.nutrient = nutrient;
            nutrientData.nutrientValue = [row numberForColumn:USDA_NUT_DATA_COL__NUTR_VAL];
            nutrientData.nutrientNo = nutrientNumber;
            nutrientData.foodNdbNo = [row stringForColumn:USDA_NUT_DATA_COL__NDB_NO];
            
            
        }
    }
    
    [self saveCoreData:context];
    
    @autoreleasepool {
    //import the nutrient file
    NSLog(@"nutrient");
    usdaParser = [[USDATableParser alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"NUTR_DEF" ofType:@"txt" ]];
    while(  (row = [usdaParser readDatabaseRow]) )
    {
        NSString *nutrientNumber = [row stringForColumn:USDA_NUTR_DEF_COL__NUTR_NO] ;
        if( ![self isWhitelistedNutrient:nutrientNumber] ) continue;
        
        Nutrient *nutrient = [NSEntityDescription
                              insertNewObjectForEntityForName:[Nutrient entityName] 
                              inManagedObjectContext:context];
        
        nutrient.name = [Nutrient friendlyNameForNutrientNo:nutrientNumber];
        
        
        nutrient.units = [row stringForColumn:USDA_NUTR_DEF_COL__UNITS];
        
        nutrient.nutrientNo =nutrientNumber;
        NSLog(@"nutr: %@, %@", nutrient.name, nutrient.nutrientNo);
        

        
        NSFetchRequest * nutrData = [[NSFetchRequest alloc] init];
        [nutrData setEntity:[NSEntityDescription entityForName:[FoodNutrientData entityName] inManagedObjectContext:context]];
        [nutrData setPredicate:[NSPredicate predicateWithFormat:@"nutrientNo = %@", nutrient.nutrientNo]];
        
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:nutrData error:&error];
        for (FoodNutrientData *fnd in results)
        {
            fnd.nutrient = nutrient;
        }
        
    }
    }
    
    [self saveCoreData:context];    
    @autoreleasepool {
    //import the food group file
    NSLog(@"food group");
    usdaParser = [[USDATableParser alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"FD_GROUP" ofType:@"txt" ]];
    while(  (row = [usdaParser readDatabaseRow]) ){
        FoodGroup *group = [NSEntityDescription
                              insertNewObjectForEntityForName:[FoodGroup entityName] 
                              inManagedObjectContext:context];
        
        group.name = [row stringForColumn:USDA_FD_GROUP_COL__FDGRP_DESC];
        group.code = [row stringForColumn:USDA_FD_GROUP_COL__FDGRP_CD];
        
    }
    }
    
        [self saveCoreData:context];
    @autoreleasepool {
    //import the unit weights file
    NSLog(@"unit weights");
    usdaParser = [[USDATableParser alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"WEIGHT" ofType:@"txt" ]];
    while(  (row = [usdaParser readDatabaseRow]) ){
        FoodUnitWeight *unit = [NSEntityDescription
                            insertNewObjectForEntityForName:[FoodUnitWeight entityName] 
                            inManagedObjectContext:context];
        
        unit.unitName = [row stringForColumn:USDA_WEIGHT_COL__MSRE_DESC];
        unit.gramWeight = [row numberForColumn:USDA_WEIGHT_COL__GM_WGHT];
        unit.amount = [row numberForColumn:USDA_WEIGHT_COL__AMOUNT];
        unit.ndbNo = [row stringForColumn:USDA_WEIGHT_COL__NDB_NO];
        
    }
    }
    [self saveCoreData:context];
    @autoreleasepool {
    //import the food description file
    NSLog(@"food description");
    int foodNum = 0;
    usdaParser = [[USDATableParser alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"FOOD_DES" ofType:@"txt" ]];
    while(  (row = [usdaParser readDatabaseRow]) ){
        
        foodNum++;
        //NSLog(@"food # %d", foodNum);
        
        // blacklisting food 23999 because it does not have any nutrient data associated to it
        NSString *ndbNo = [row stringForColumn:USDA_FOOD_DES_COL__NDB_NO];
        if([ndbNo isEqualToString:@"23999"]) continue;
        
        
        Food *food = [NSEntityDescription
                                insertNewObjectForEntityForName:[Food entityName] 
                                inManagedObjectContext:context];
        
        food.descriptionLong = [row stringForColumn:USDA_FOOD_DES_COL__LONG_DESC];
        food.descriptionShort = [row stringForColumn:USDA_FOOD_DES_COL__SHRT_DESC];
        food.commonNames = [row stringForColumn:USDA_FOOD_DES_COL__COMNAME];
        food.manufacturer = [row stringForColumn:USDA_FOOD_DES_COL__MANUFACNAME];

        
        //setup relationships to other entities
        food.ndbNo = [row stringForColumn:USDA_FOOD_DES_COL__NDB_NO];
        //unit weights
        
        
        
        //NSLog(@"food -> unit rel");
        NSFetchRequest * foodUnitWeightFetch = [[NSFetchRequest alloc] init];
        [foodUnitWeightFetch setEntity:[NSEntityDescription entityForName:[FoodUnitWeight entityName] inManagedObjectContext:context]];
        [foodUnitWeightFetch setPredicate:[NSPredicate predicateWithFormat:@"ndbNo = %@", food.ndbNo]];
        
        NSError *error = nil;
        NSArray *fuws = [context executeFetchRequest:foodUnitWeightFetch error:&error];
        if ([fuws count]==0)
        {
            //if there are no unit conversions defined,
            //create a default one for ounces 
            //(safe to do since weight-to-weight conversions the same for all foods)
            FoodUnitWeight *unit = [NSEntityDescription
                                    insertNewObjectForEntityForName:[FoodUnitWeight entityName] 
                                    inManagedObjectContext:context];
            
            unit.unitName = @"oz";
            unit.gramWeightValue = 28.349; //per National Institute of Standards and Technology
            //Household  Weights and Measures Division (NIST SP 430) - 2004
            //http://www.nist.gov/pml/wmd/metric/upload/sp430-household-wm-pdf.pdf
            unit.amountValue = 1;
            unit.ndbNo = food.ndbNo;

            [food addUnitWeightsObject:unit];
        }
        
        for (FoodUnitWeight *fuw in fuws)
        {
            [food addUnitWeightsObject:(fuw)];
        }

        //food group
        //NSLog(@"food -> group rel");
        food.foodGroupCode = [row stringForColumn:USDA_FOOD_DES_COL__FDGRP_CD];
        NSFetchRequest * foodGroupFetch = [[NSFetchRequest alloc] init];
        [foodGroupFetch setEntity:[NSEntityDescription entityForName:[FoodGroup entityName] inManagedObjectContext:context]];
        [foodGroupFetch setPredicate:[NSPredicate predicateWithFormat:@"code = %@", food.foodGroupCode]];
        
        error = nil;
        NSArray *groups = [context executeFetchRequest:foodGroupFetch error:&error];
        [((FoodGroup*)[groups objectAtIndex:0]) addFoodsObject:food];
        
        //nutrient data
        //NSLog(@"food -> nut data rel");
        NSFetchRequest * nutrientDataFetch = [[NSFetchRequest alloc] init];
        [nutrientDataFetch setEntity:[NSEntityDescription entityForName:[FoodNutrientData entityName] inManagedObjectContext:context]];
        [nutrientDataFetch setPredicate:[NSPredicate predicateWithFormat:@"foodNdbNo = %@", food.ndbNo]];
        
        error = nil;
        NSArray *nutDatas = [context executeFetchRequest:nutrientDataFetch error:&error];
        for (FoodNutrientData *nutData in nutDatas){
            [food addNutrientsObject:(nutData)];
        }
        
    }
    }
    [self saveCoreData:context];

   }


@end
