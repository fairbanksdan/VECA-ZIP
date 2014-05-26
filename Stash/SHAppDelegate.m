//
//  SHAppDelegate.m
//  Stash
//
//  Created by Taylor Potter on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAppDelegate.h"

#import "SHStashAPI.h"

@implementation SHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[SHStashAPI sharedAPI]GETRequestForStash:@"" completion:^(NSError *error) {
        //
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // ...
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // ...
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // ...
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // ...
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // ...
}

@end
