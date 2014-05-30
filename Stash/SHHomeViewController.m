//
//  SHHomeViewController.m
//  Stash
//
//  Created by iC on 5/28/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHHomeViewController.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"Home loaded...");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"Home view did dissapear...");
}

- (IBAction)addStashButtonSelected:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddStashButtonSelected object:nil];
    
}
- (IBAction)browseButtonSelected:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kBrowseButtonSelected object:nil];
    
}

@end
