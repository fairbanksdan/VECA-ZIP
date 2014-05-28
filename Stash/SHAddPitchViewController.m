//
//  SHAddPitchViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddPitchViewController.h"

@interface SHAddPitchViewController ()

@end

@implementation SHAddPitchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (IBAction)showHint:(id)sender
{
    UIViewController *popover = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverVC"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
*/

@end
