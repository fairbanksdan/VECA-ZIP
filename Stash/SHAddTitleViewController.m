//
//  SHAddTitleViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddTitleViewController.h"

@interface SHAddTitleViewController ()

- (void)didSaveToCoreData;
- (IBAction)trashStashButtonSelected:(id)sender;

@end

@implementation SHAddTitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pitchTextView setText:[[[SHStashCloud sharedCloud]stash]text]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSaveToCoreData) name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[[SHStashCloud sharedCloud]stash]setTitle:self.titleTextField.text];
}

- (void)didSaveToCoreData
{
    self.titleTextField.text = nil;
    self.pitchTextView.text = nil;
}

- (IBAction)trashStashButtonSelected:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kTrashStashButtonSelected object:nil];
}

- (IBAction)showHint:(id)sender {
    
    UIViewController *popover = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverTitleVC"];
    popover.view.bounds = CGRectMake(0, 0, 260, 300);
    popover.view.center = self.view.center;
    popover.view.alpha = 0.f;
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:popover.view.bounds];
    
    //    popover.view.center = CGPointMake(self.view.center.x, self.view.frame.size.height);
    
    [self.view addSubview:popover.view];
    [popover.view addSubview:dismissButton];
    [dismissButton addTarget:self action:@selector(dismissPopover:) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         //                         popover.view.center = self.view.center;
                         popover.view.alpha = 1.f;
                     }];
}

- (void)dismissPopover:(id)sender
{
    UIView *popoverView = [(UIButton *)sender superview];
    [UIView animateWithDuration:0.4
                     animations:^{
                         popoverView.alpha = 0.f;
                     } completion:^(BOOL finished) {
                         [popoverView removeFromSuperview];
                     }];
}

@end
