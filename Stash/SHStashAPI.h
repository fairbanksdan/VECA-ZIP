//
//  SHStashAPI.h
//  Stash
//
//  Created by iC on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Completion handler for API calls.
 *
 *  @param error returns the error if the API call failed.
 *  Check against the error, and if nil, the network call 
 *  completed successfully.
 */
typedef void(^StashAPICompletionHandler)(NSError *error);

@interface SHStashAPI : NSObject

/**
 *  Singleton setup. 
 *  Network calls will be made against singleton class.
 *  There is a reason for that. We want to make sure we set
 *  HTTPAdditionalHeaders on NSURLSessionConfiguration / NSURLSession
 *  once to keep the methods clean and precise.
 *
 *  @return instance of SHStashAPI class.
 */
+ (SHStashAPI *)sharedAPI;

// Method for creating a POST request to Parse. This will create the Parse object without any permission.
- (void)POSTRequestForStashWithTitle:(NSString *)title text:(NSString *)text uuid:(NSString *)uuid completion:(StashAPICompletionHandler)completionHandler;

// Method for GETting a stash from Parse for specific stash ID (stash).
- (void)GETRequestForStash:(NSString *)stash completion:(StashAPICompletionHandler)completionHandler;

// Method for DELETing a stash from Parse for specific stash IS (stash)
- (void)DELETERequestForStashWithID:(NSString *)stash completion:(StashAPICompletionHandler)completionHandler;

@end
