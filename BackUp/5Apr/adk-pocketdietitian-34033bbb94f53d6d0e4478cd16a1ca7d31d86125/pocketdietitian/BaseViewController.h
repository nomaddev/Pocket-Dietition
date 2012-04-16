//
//  BaseViewController.h
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/31/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface BaseViewController : UIViewController


-(AppDelegate *) appDelegate;
-(UIViewController *) rootViewController;
- (NSManagedObjectContext *) sharedManagedObjectContext;

- (BOOL)findAndResignFirstResponder;

@end
