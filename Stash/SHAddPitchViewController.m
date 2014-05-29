//
//  SHAddPitchViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddPitchViewController.h"
#import "CoreData+MagicalRecord.h"
#import "SHStash.h"

@interface SHAddPitchViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) SHStash *stash;

@end

@implementation SHAddPitchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *color = [UIColor whiteColor];
    _pitchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter the pitch for your idea here" attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.stash = [SHStash createEntity];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"AddPitch view did dissapear...");
    [_pitchTextField resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.pitchTextField resignFirstResponder];
}

@end
