//
//  SearchFoodViewController.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/6/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchFoodViewController : BaseViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>{
    @private
    NSArray *searchResults;
    BOOL noResults;
}
@property (unsafe_unretained, nonatomic) IBOutlet UISearchBar *searchBar;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *searchResultsTableView;


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
