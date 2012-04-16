//
//  NFNFoodTableCell.m
//  pocketdietitian
//
//  Created by Rafael Santiago, Jr. on 2/13/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "NFNFoodTableCell.h"

@implementation NFNFoodTableCell
@synthesize foodLabel;
@synthesize unitLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
