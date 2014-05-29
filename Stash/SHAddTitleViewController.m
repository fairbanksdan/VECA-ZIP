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

@end
