#import "FoodNutrientData.h"

@implementation FoodNutrientData

// Custom logic goes here.

-(float) nutrientValueForGramAmount:(float) gramAmount{
    
    return ([self.nutrientValue floatValue]/100) * gramAmount;
}
@end
