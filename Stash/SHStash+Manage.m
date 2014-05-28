//
//  SHStash+Manage.m
//  Stash
//
//  Created by Reed Sweeney on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHStash+Manage.h"

@implementation SHStash (Manage)

- (void)saveStash
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
            stash.stashID = [[[[[NSUUID UUID]UUIDString]lowercaseString]stringByReplacingOccurrencesOfString:@"-" withString:@""]substringToIndex:12];
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
        completionHandler([NSError errorWithDomain:@"ERROR: Duplicate Idea Title" code:1001 userInfo:nil]);
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

+ (void)editStash:(SHStash *)stash title:(NSString *)title text:(NSString *)text category:(NSString *)category comletion:(SHStashCompletionHandler)completionHandler
{
    if (title) { stash.title = title; }
    if (text) { stash.text = text; }
    if (category) { stash.category = category; }
    
    // Persisting Data.
    [stash saveStash];
    
    // Notifying of completion.
    completionHandler(nil);
}

@end











