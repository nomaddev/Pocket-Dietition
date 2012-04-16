//
//  BaseViewController.m
//  pocketdietitian
//
//  Created by Andrej Kostresevic on 1/31/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@implementation BaseViewController

-(AppDelegate *) appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(UIViewController *) rootViewController
{
    return [self appDelegate].rootViewController;
}

- (NSManagedObjectContext *) sharedManagedObjectContext
{
    return [[self appDelegate] managedObjectContext];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
//    NSLog(@"BaseViewController touchesEnded");
    
    UITouch *touch = [touches anyObject];
    if (![[touch view] isFirstResponder]) 
    {
        [self findAndResignFirstResponder];
    }
}

- (BOOL)_findAndResignFirstResponderFromView: (UIView *) startingView
{
//    NSLog(@"_findAndResignFirstResponderFromView");
    if (startingView.isFirstResponder) {
        [startingView resignFirstResponder];
        return YES;     
    }
//    NSLog(@"_findAndResignFirstResponderFromView iterate");
    for (UIView *subView in startingView.subviews) 
    {
        if ([self _findAndResignFirstResponderFromView:subView])
            return YES;
    }
    return NO;
}

- (BOOL)findAndResignFirstResponder
{
//    NSLog(@"findAndResignFirstResponder");
    return [self _findAndResignFirstResponderFromView:self.view];
}


@end
