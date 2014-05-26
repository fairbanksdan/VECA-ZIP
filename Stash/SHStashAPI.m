//
//  SHStashAPI.m
//  Stash
//
//  Created by iC on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHStashAPI.h"
#import "SHStash+Manage.h"

@interface SHStashAPI ()

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation SHStashAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"X-Parse-Application-Id": kApplicationID, @"X-Parse-REST-API-Key" : kRESTAPIKey};
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    return self;
}

+ (SHStashAPI *)sharedAPI
{
    static SHStashAPI *sharedAPI;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPI = [[[self class]alloc]init];
    });
    
    return sharedAPI;
}

#pragma mark - API Calls

- (void)POSTRequestForStashWithTitle:(NSString *)title text:(NSString *)text completion:(StashAPICompletionHandler)completionHandler
{
    NSDictionary *parameters = @{@"title" : title, @"text" : text};
    NSData *parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [self requestForHTTPMethod:@"POST" withURL:[NSURL URLWithString:kStashAPIURL]];
    
    [request setHTTPBody:parametersData];
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            completionHandler(nil);
        } else {
            completionHandler(error);
        }
    }]resume];
}

- (void)GETRequestForStash:(NSString *)stash completion:(StashAPICompletionHandler)completionHandler
{
    NSString *stashURLString = [NSString  stringWithFormat:@"%@/%@", kStashAPIURL, stash];

    [[self.session dataTaskWithURL:[NSURL URLWithString:stashURLString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            
            NSDictionary *stash = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [SHStash stashWithTitle:stash[@"title"] text:stash[@"text"] origin:NO completion:^(NSError *error) {
                             if (!error) {
                                 [[SHStashAPI sharedAPI]DELETERequestForStashWithID:stash[@"objectId"] completion:^(NSError *error) {
                                     if (!error) {
                                         completionHandler(nil);
                                     }
                                 }];
                             } else {
                                 completionHandler(error);
                             }
                         }];
            
            completionHandler(nil);
        } else {
            completionHandler(error);
        }
    }]resume];
}

- (void)DELETERequestForStashWithID:(NSString *)stash completion:(StashAPICompletionHandler)completionHandler
{
    NSString *stashURLString = [NSString  stringWithFormat:@"%@/%@", kStashAPIURL, stash];
    NSMutableURLRequest *request = [self requestForHTTPMethod:@"DELETE" withURL:[NSURL URLWithString:stashURLString]];
    
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            completionHandler(nil);
        } else {
            completionHandler(error);
        }
    }]resume];
}

#pragma mark - Helper Methods

- (NSMutableURLRequest *)requestForHTTPMethod:(NSString *)method withURL:(NSURL *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:method];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    return request;
}

@end









