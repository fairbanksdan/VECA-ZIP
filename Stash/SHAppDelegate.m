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
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Stash"]; return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[SHStashAPI sharedAPI]GETRequestForStash:[[url.absoluteString componentsSeparatedByString:@"="]lastObject]
                                   completion:^(NSError *error) {
        if (!error) {
            NSLog(@"Stash retrieved. Saved to CoreData. Deleted from the server.");
        }
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
