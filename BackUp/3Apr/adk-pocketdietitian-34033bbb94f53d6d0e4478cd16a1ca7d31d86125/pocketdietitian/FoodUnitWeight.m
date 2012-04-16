#import "FoodUnitWeight.h"

@implementation FoodUnitWeight

// Custom logic goes here.

-(float) totalGramWeightForAmountConsumed:(NSNumber*) amountConsumed{
    return [amountConsumed floatValue] * ([self.gramWeight floatValue]/[self.amount floatValue]);
}
@end
