//
//  SHAddCategoryViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddCategoryViewController.h"
#import "SHStash+Manage.h"

@interface SHAddCategoryViewController ()

- (IBAction)stashITButtonSelected:(UIButton *)sender;

@end

@implementation SHAddCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.titleTextLabel setText:[[[SHStashCloud sharedCloud]stash]title]];
    [self.pitchTextView setText:[[[SHStashCloud sharedCloud]stash]text]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[[SHStashCloud sharedCloud]stash]setCategory:@"Music"];
}

#pragma mark - Action Methods

- (IBAction)stashITButtonSelected:(UIButton *)sender
{
    if ([[[[SHStashCloud sharedCloud]stash]title]length] && [[[[SHStashCloud sharedCloud]stash]text]length]) {
        [[[SHStashCloud sharedCloud]stash]saveStash];
        [[[SHStashCloud sharedCloud]stash]setTitle:nil];
        [[[SHStashCloud sharedCloud]stash]setText:nil];
    } else {
        [[[UIAlertView alloc]initWithTitle:@"Hold on..."
                                   message:@"You need to have both the title and the idea text entered before you can save."
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil, nil]show];
    }
}

@end
