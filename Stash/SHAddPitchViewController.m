//
//  SHAddPitchViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddPitchViewController.h"

@interface SHAddPitchViewController () <UITextFieldDelegate>

- (void)didSaveToCoreData;
- (IBAction)trashStashButtonSelected:(id)sender;

@end

@implementation SHAddPitchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *color = [UIColor whiteColor];
    _pitchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter the pitch for your idea here"
                                                                            attributes:@{NSForegroundColorAttributeName:color}];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSaveToCoreData) name:NSManagedObjectContextDidSaveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSaveToCoreData) name:kTrashStashButtonSelected object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[[SHStashCloud sharedCloud]stash]setText:self.pitchTextField.text];
}

- (void)didSaveToCoreData
{
    self.pitchTextField.text = nil;
}

- (IBAction)trashStashButtonSelected:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kTrashStashButtonSelected object:nil];
}

@end
