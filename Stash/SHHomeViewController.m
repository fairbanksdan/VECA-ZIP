//
//  SHHomeViewController.m
//  Stash
//
//  Created by iC on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHStashAPI.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SHStashAPI sharedAPI]POSTRequestForStashWithTitle:@"New Note" text:@"New text." completion:^(NSError *error) {
        if (!error) {
            NSLog(@"Success...");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
