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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"Add pitch...");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *color = [UIColor whiteColor];
    _pitchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter the pitch for your idea here" attributes:@{NSForegroundColorAttributeName: color}];
}

@end
