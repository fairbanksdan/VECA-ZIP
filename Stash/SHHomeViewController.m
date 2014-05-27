//
//  SHHomeViewController.m
//  Stash
//
//  Created by iC on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHStashAPI.h"
#import "SHStash+Manage.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SHStashAPI sharedAPI]GETRequestForStash:@"88546dfe3ee0" completion:^(NSError *error) {
        if (!error) {
            NSLog(@"Done.");
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
