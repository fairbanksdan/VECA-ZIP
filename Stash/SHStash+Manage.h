//
//  SHStash+Manage.h
//  Stash
//
//  Created by Reed Sweeney on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHStash.h"

/**
 *  Completion handler for saving / deletion of Stash ideas.
 *
 *  @param error returns the error if the API call failed.
 *  Check against the error, and if nil, the network call
 *  completed successfully.
 */
typedef void(^SHStashCompletionHandler)(NSError *error);

@interface SHStash (Manage)

// This method triggers both default & root saving context save.
// Call this method on SHStash when "save" button is tapped.
+ (void)save;

// Method for creating stash with title, text and origin.
+ (void)stashWithTitle:(NSString *)title text:(NSString *)text origin:(BOOL)isMine completion:(SHStashCompletionHandler)completionHandler;

// Method for deleting stash from Core Data.
+ (void)deleteStash:(SHStash *)stash completion:(SHStashCompletionHandler)completionHandler;

// Method for stash editing with new titlt and text.
+ (void)editStash:(SHStash *)stash title:(NSString *)title text:(NSString *)text comletion:(SHStashCompletionHandler)completionHandler;

@end
