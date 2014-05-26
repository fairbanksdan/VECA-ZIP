//
//  SHStash+Manage.m
//  Stash
//
//  Created by Reed Sweeney on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHStash+Manage.h"

@implementation SHStash (Manage)

+ (void)save
{
    [[NSManagedObjectContext defaultContext]save:nil];
    [[NSManagedObjectContext rootSavingContext]save:nil];
}

+ (void)stashWithTitle:(NSString *)title text:(NSString *)text origin:(BOOL)isMine completion:(SHStashCompletionHandler)completionHandler
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", title];
    NSArray *results = [SHStash findAllWithPredicate:predicate];
    if ([results count] == 0) {
        [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
            SHStash *stash = [SHStash createInContext:localContext];
            stash.title = title;
            stash.text = text;
            stash.stashID = [[NSUUID UUID] UUIDString];
            stash.date = [NSDate date];
            stash.isMine = @(isMine);
        } completion:^(BOOL success, NSError *error) {
            if (!error) {
                completionHandler(nil);
            }
            else {
                completionHandler(error);
            }
        }];
    }
    else if ([results count] > 0) {
        NSError *duplicateError = [NSError errorWithDomain:@"DUPLICATE TITLE" code:1001 userInfo:nil];
        completionHandler(duplicateError);
        return;
    }
}

+ (void)deleteStash:(SHStash *)stash completion:(SHStashCompletionHandler)completionHandler
{
    [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
        [localContext deleteObject:stash];
    } completion:^(BOOL success, NSError *error) {
        if (!error) {
            completionHandler(nil);
        }
        else {
            completionHandler(error);
        }
    }];
}

+ (void)editStash:(SHStash *)stash title:(NSString *)title text:(NSString *)text comletion:(SHStashCompletionHandler)completionHandler
{
    NSLog(@"not implemented bro");
}

@end











