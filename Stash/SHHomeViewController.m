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
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SHHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[SHStashAPI sharedAPI]POSTRequestForStashWithTitle:@"New Note 2" text:@"New text." completion:^(NSError *error) {
//        if (!error) {
//            NSLog(@"Success...");
//        }
//    }];
//    
//    [[SHStashAPI sharedAPI]GETRequestForStash:@"RazpK3rQ1f" completion:^(NSError *error) {
//        if (!error) {
//            NSLog(@"Got one...");
//        }
//    }];

    
    
    [[SHStashAPI sharedAPI]DELETERequestForStashWithID:@"uSx03AzINr" completion:^(NSError *error) {
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
