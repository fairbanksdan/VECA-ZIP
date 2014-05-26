//
//  SHStashAPI.m
//  Stash
//
//  Created by iC on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHStashAPI.h"

static NSString * const kApplicationID = @"5oK2qPw5vlbibl7wPWT75Fi2qgcUyotNn9fMI2Q6";
static NSString * const kRESTAPIKey = @"KCSSKiRP1QP3uaRf9BY332XQSwjIe672yCDPUTeB";
static NSString * const kStashAPIURL = @"https://api.parse.com/1/classes/Stash";

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

- (void)POSTRequestForStashWithTitle:(NSString *)title text:(NSString *)text completion:(StashAPICompletionHandler)completionHandler
{
    NSDictionary *parameters = @{@"title" : title, @"text" : text};
    NSData *parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kStashAPIURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:parametersData];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // Handle success or failure.
        
    }]resume];
}

- (void)GETRequestForStash:(NSString *)stash completion:(StashAPICompletionHandler)completionHandler
{
    NSString *stashURLString = [NSString  stringWithFormat:@"%@/%@", kStashAPIURL, stash];

    [[self.session dataTaskWithURL:[NSURL URLWithString:stashURLString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *stash = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        // Save to Core Data + as soon as it is persisted (completion)... Make a network call to delete the idea.
        
    }]resume];
}

@end
