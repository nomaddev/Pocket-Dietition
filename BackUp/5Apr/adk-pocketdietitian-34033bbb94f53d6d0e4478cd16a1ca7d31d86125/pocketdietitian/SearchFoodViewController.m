//
//  SearchFoodViewController.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 2/6/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "SearchFoodViewController.h"

#import "Food.h"
#import "FoodAmountViewController.h"

#import "NSManagedObjectContext+NSManagedObjectContext_blocks.m"

@implementation SearchFoodViewController
@synthesize searchBar;
@synthesize searchResultsTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = searchBar;
    NSFetchRequest * allFoodsFetchRequest = [[NSFetchRequest alloc] init];
    [allFoodsFetchRequest setEntity:[NSEntityDescription entityForName:[Food entityName] inManagedObjectContext:[self sharedManagedObjectContext]]];
    [allFoodsFetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"descriptionLong", @"ndbNo", nil]];
    noResults = FALSE;
   }

- (void)viewDidUnload
{
    [self setSearchResultsTableView:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

NSString *lastSearchText;
#pragma mark - Search Bar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    lastSearchText = searchText;
    if ([searchText length]<2)
    {
        NSLog(@"empty search");
        searchResults = [[NSArray alloc] initWithObjects:nil];
        
        [searchResultsTableView reloadData];
        return;
    }
    
        NSLog(@"========= %@ ============", searchText);
        //search
        NSFetchRequest * searchFetchRequest = [[NSFetchRequest alloc] init];
        [searchFetchRequest setEntity:[NSEntityDescription entityForName:[Food entityName] inManagedObjectContext:[self sharedManagedObjectContext]]];
        [searchFetchRequest setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"descriptionLong" ascending:TRUE]]];

        
//        [searchFetchRequest setFetchLimit:20];
        
        if ([searchText length]<3)
        {
//                [[self sharedManagedObjectContext] executeFetchRequest:searchFetchRequest error:nil];
//            NSLog(@"fetched sync done");
           
            [searchFetchRequest setPredicate:[NSPredicate predicateWithFormat:@"descriptionLong BEGINSWITH[c] %@", searchText]];   
            [[self sharedManagedObjectContext] executeFetchRequestInBackground:searchFetchRequest withTag:searchText onComplete:^(NSArray *results, id tag) 
             {
                 if (![tag isEqualToString:lastSearchText])
                     return;
                 searchResults = results;
                 
                 noResults = ([searchResults count]==0);
                 
                 [searchResultsTableView reloadData];
             } onError:^(NSError *error, id tag) {
                 NSLog(@"FAIL");
             }];
        }
        else
        {
            
            [searchFetchRequest setPredicate:[NSPredicate predicateWithFormat:@"descriptionLong BEGINSWITH[c] %@", searchText]];   
            
            NSLog(@"fetch");
//            searchResults = [[self sharedManagedObjectContext] executeFetchRequest:searchFetchRequest error:&error];
            [[self sharedManagedObjectContext] executeFetchRequestInBackground:searchFetchRequest withTag:searchText onComplete:^(NSArray *results, id tag) 
            {
                if (![tag isEqualToString:lastSearchText])
                    return;
                NSLog(@"display BEGINS results for : %@", searchText);
                searchResults = results;
                
                //only refresh the display if we had some BEGINS results
                //if not - wait for the MATCHES query to come in before telling the user there were no results
                if ([searchResults count]>0)
                    [searchResultsTableView reloadData];
                
                [searchFetchRequest setPredicate:[NSPredicate predicateWithFormat:@"descriptionLong MATCHES[c] %@", [NSString stringWithFormat:@".+\\b%@.*", searchText]]];
                
                [[self sharedManagedObjectContext] executeFetchRequestInBackground:searchFetchRequest withTag:searchText onComplete:^(NSArray *results, id tag) 
                 {
                     if (![tag isEqualToString:lastSearchText])
                         return;
                     NSLog(@"display MATCHES results for : %@", searchText);
                     
                     noResults = ([searchResults count]==0 && [results count]==0);
                         
                     
                     searchResults = [searchResults arrayByAddingObjectsFromArray:results];
                     
                     
                     [searchResultsTableView reloadData];
                     
                 } onError:^(NSError *error, id tag) {
                     NSLog(@"FAIL");
                 }];    
                
                //old sort method - it was querying everything containing the search term, then SORTING THE THINGS STARTING WITH THE SEARCH TERM FIRST WHOAcapslock
                //no longer needed because we now send 2 async fetch requests - one for BEGINS, another for CONTAINS, then merge them
                
//                 NSLog(@"sort");
//                searchResults = [results sortedArrayUsingComparator: ^(Food *obj1, Food *obj2) 
//                                 {
//                                     //NSLog(@"compare: %@, %@", obj1.descriptionLong, obj2.descriptionLong);
//                                     //if obj1 begins with searchText and obj2 does not
//                                     if ([[obj1.descriptionLong lowercaseString] hasPrefix:searchText] && ![[obj2.descriptionLong lowercaseString] hasPrefix:searchText]) {
//                                         return (NSComparisonResult)NSOrderedAscending;
//                                     }
//                                     
//                                     //if obj2 begins with searchText and obj1 does not
//                                     if (![[obj1.descriptionLong lowercaseString] hasPrefix:searchText] && [[obj2.descriptionLong lowercaseString] hasPrefix:searchText]) {
//                                         return (NSComparisonResult)NSOrderedDescending;
//                                     }
//                                     
//                                     return (NSComparisonResult)NSOrderedSame;
//                                     
//                                 }];
//                NSLog(@"sort done");
                
                
                
            } onError:^(NSError *error, id tag) {
                NSLog(@"FAIL");
            }];
            
        }
        
       
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (noResults) return 1;
    
    if(!searchResults) return 0;
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (noResults) 
    {
        UITableViewCell *cellView = [[UITableViewCell alloc] init];
        [cellView.textLabel setText:@"No results"];
        cellView.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cellView;
    }
    
    if(!searchResults) return nil;
    
    Food *food = [searchResults objectAtIndex: [indexPath row]];
    
    UITableViewCell *cellView = [[UITableViewCell alloc] init];
    [cellView.textLabel setText:food.descriptionLong];
    
    return cellView;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (noResults) return;
    
    Food *food = [searchResults objectAtIndex: [indexPath row]];
    
    FoodAmountViewController *foodAmountVC = [[FoodAmountViewController alloc] initWithFood:food];
    
    [self.navigationController pushViewController:foodAmountVC animated:TRUE];
    
}


@end
