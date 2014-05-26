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
    
//
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)create:(id)sender {
  [SHStash stashWithTitle:@"App Name" text:@"This app is awesome" origin:YES completion:^(NSError *error) {
    if (!error) {
      NSLog(@"Success!!");
    }
  }];
}
- (IBAction)delete:(id)sender {
  NSArray *results = [SHStash findAll];
  for (SHStash *stash in results) {
//    NSLog(@"%@",stash.title);
    [SHStash deleteStash:stash completion:^(NSError *error) {
      NSLog(@"Deleted Stash");
    }];
  }
}
- (IBAction)read:(id)sender {
}

@end
