//
//  SHAddCategoryViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddCategoryViewController.h"

@interface SHAddCategoryViewController ()

@end

@implementation SHAddCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)showCategoryPopover:(id)sender {
    UIViewController *popover = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverCategoryVC"];
    popover.view.bounds = CGRectMake(0, 0, 300, 500);
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
