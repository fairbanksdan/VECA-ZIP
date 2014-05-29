//
//  SHStashCloud.h
//  Stash
//
//  Created by iC on 5/29/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHStash.h"

@interface SHStashCloud : NSObject

@property (strong, nonatomic) SHStash *stash;

+ (instancetype)sharedCloud;
- (void)deleteStash;

@end
