//
//  SHBrowseIdeasViewController.m
//  Stash
//
//  Created by Reed Sweeney on 5/29/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHBrowseIdeasViewController.h"

@interface SHBrowseIdeasViewController ()

@end

@implementation SHBrowseIdeasViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"Browse loaded...");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"BrowseIdeas view did dissapear...");
}

@end
