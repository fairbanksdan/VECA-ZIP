//
//  SHStashCloud.m
//  Stash
//
//  Created by iC on 5/29/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHStashCloud.h"
#import "CoreData+MagicalRecord.h"

@implementation SHStashCloud

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _stash = [SHStash createEntity];
        
    }
    return self;
}

+ (instancetype)sharedCloud
{
    static SHStashCloud *sharedStash = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStash = [[[self class]alloc]init];
    });
    
    return sharedStash;
}

- (void)deleteStash
{
    self.stash = nil;
}

@end
