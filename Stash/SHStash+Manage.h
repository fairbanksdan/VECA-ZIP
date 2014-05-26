//
//  SHStash+Manage.h
//  Stash
//
//  Created by Reed Sweeney on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHStash.h"

typedef void(^SHStashCompletionHandler)(NSError *error);

@interface SHStash (Manage)

+ (void)stashWithTitle:(NSString *)title text:(NSString *)text origin:(BOOL)isMine completion:(SHStashCompletionHandler)completionHandler;
+ (void)deleteStash:(SHStash *)stash completion:(SHStashCompletionHandler)completionHandler;
+ (void)editStash:(SHStash *)stash title:(NSString *)title text:(NSString *)text comletion:(SHStashCompletionHandler)completionHandler;

@end
