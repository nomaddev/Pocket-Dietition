#import "Nutrient.h"

#import "Constants.h"

@implementation Nutrient

// Custom logic goes here.

//"static" vars

NSMutableDictionary *nutrientFriendlyNames;
NSMutableDictionary *nutrientFriendlyTooMuchLanguage;
BOOL initted;

+(void) initializeNutrientLanguage
{
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

    //TODO: add other nutrients as needed
    
    nutrientFriendlyNames = [[NSMutableDictionary alloc] initWithCapacity:11];
    
    [nutrientFriendlyNames setObject:@"Sodium" forKey:kSODIUM];
    [nutrientFriendlyNames setObject:@"Potassium" forKey:kPOTASSIUM];
    [nutrientFriendlyNames setObject:@"Phosphorus" forKey:kPHOSPHORUS];
    [nutrientFriendlyNames setObject:@"Protein" forKey:kPROTEIN];
    [nutrientFriendlyNames setObject:@"Fluids" forKey:kFLUIDS];
    [nutrientFriendlyNames setObject:@"Calories" forKey:kCALORIES];
    [nutrientFriendlyNames setObject:@"Net Carbs" forKey:kCARBS];
    [nutrientFriendlyNames setObject:@"Fat" forKey:kFAT];
    [nutrientFriendlyNames setObject:@"Cholesterol" forKey:kCHOLESTEROL];
    [nutrientFriendlyNames setObject:@"Fiber" forKey:kFIBER];
    
    nutrientFriendlyTooMuchLanguage = [[NSMutableDictionary alloc] initWithCapacity:11];
    
    [nutrientFriendlyTooMuchLanguage setObject:@"too much Sodium" forKey:kSODIUM];
    [nutrientFriendlyTooMuchLanguage setObject:@"too much Potassium" forKey:kPOTASSIUM];
    [nutrientFriendlyTooMuchLanguage setObject:@"too much Phosphorus" forKey:kPHOSPHORUS];
    [nutrientFriendlyTooMuchLanguage setObject:@"too much Protein" forKey:kPROTEIN];
    [nutrientFriendlyTooMuchLanguage setObject:@"too much Fluids" forKey:kFLUIDS];
    [nutrientFriendlyTooMuchLanguage setObject:@"too many Calories" forKey:kCALORIES];
    [nutrientFriendlyTooMuchLanguage setObject:@"too many Carbs" forKey:kCARBS];
    [nutrientFriendlyTooMuchLanguage setObject:@"too much Fat" forKey:kFAT];
    [nutrientFriendlyTooMuchLanguage setObject:@"too much Cholesterol" forKey:kCHOLESTEROL];
    [nutrientFriendlyTooMuchLanguage setObject:@"too much Fiber" forKey:kFIBER];
    
    initted = TRUE;
}

+(NSString *) friendlyTooMuchLanguageForNutrientNo: (NSString*) nutNo
{
    if (!initted)
        [self initializeNutrientLanguage];
    
    return [nutrientFriendlyTooMuchLanguage objectForKey:nutNo];
}
+(NSString *) friendlyNameForNutrientNo: (NSString*) nutNo
{
    if (!initted)
        [self initializeNutrientLanguage];
    
    return [nutrientFriendlyNames objectForKey:nutNo];
    
}


@end
