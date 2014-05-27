//
//  SHEditViewController.m
//  Stash
//
//  Created by iC on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHEditViewController.h"

@interface SHEditViewController ()

- (IBAction)shareButtonSelected:(id)sender;

@end

@implementation SHEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Methods

- (NSArray *)activityItems
{
    NSString *title = @"New Title";
    NSString *text = @"This is a very cool idea. I love it!";
    
    return @[title, text];
}

- (NSArray *)applicationActivities
{
    return nil;
}

- (IBAction)shareButtonSelected:(id)sender
{
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:[self activityItems]
                                                                                        applicationActivities:[self applicationActivities]];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
