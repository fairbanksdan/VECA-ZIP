//
//  SHAddTitleViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddTitleViewController.h"

@interface SHAddTitleViewController ()

@end

@implementation SHAddTitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[[SHStashCloud sharedCloud]stash]setTitle:self.titleTextField.text];
//    [self.titleTextField resignFirstResponder];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.titleTextField resignFirstResponder];
//}

@end
