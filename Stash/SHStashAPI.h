//
//  SHStashAPI.h
//  Stash
//
//  Created by iC on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^StashAPICompletionHandler)(NSError *error);

@interface SHStashAPI : NSObject

+ (SHStashAPI *)sharedAPI;
- (void)POSTRequestForStashWithTitle:(NSString *)title text:(NSString *)text completion:(StashAPICompletionHandler)completionHandler;
- (void)GETRequestForStash:(NSString *)stash completion:(StashAPICompletionHandler)completionHandler;
- (void)DELETERequestForStashWithID:(NSString *)stashID completion:(StashAPICompletionHandler)completionHandler;

@end
