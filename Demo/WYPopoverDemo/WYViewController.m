//
//  WYViewController.m
//
//  Created by Nicolas CHENG on 14/08/13.
//  Copyright (c) 2013 WHYERS. All rights reserved.
//

#import "WYViewController.h"
#import "WYSettingsViewController.h"

@interface WYViewController ()
{
    WYPopoverController* popoverController;
}

@end

////////////////////////////////////////////////////////////////////////////

@implementation WYViewController

@synthesize topLeftButton;
@synthesize topButton;
@synthesize topRightButton;
@synthesize leftButton;
@synthesize centerButton;
@synthesize rightButton;
@synthesize bottomLeftButton;
@synthesize bottomButton;
@synthesize bottomRightButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)tapOnButton:(id)sender
{
    if (popoverController == nil)
    {
        UIView* btn = (UIView*)sender;
        
        WYSettingsViewController* settingsViewController = [[WYSettingsViewController alloc] init];
        settingsViewController.contentSizeForViewInPopover = CGSizeMake(280, 140);
        settingsViewController.title = @"PDF Settings";
        [settingsViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)]];
        
        UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        
        UIViewController* contentViewController = navigationController;
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        popoverController.delegate = self;
        popoverController.passthroughViews = @[btn];
        popoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        popoverController.wantsDefaultContentAppearance = NO;
        [popoverController presentPopoverFromRect:btn.bounds inView:btn permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - Selectors

- (void)done:(id)sender
{
    [popoverController dismissPopoverAnimated:YES];
    popoverController.delegate = nil;
    popoverController = nil;
}

#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismiss:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismiss:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}

#pragma mark - UIViewControllerRotation

// Applications should use supportedInterfaceOrientations and/or shouldAutorotate..
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

// New Autorotation support.
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end