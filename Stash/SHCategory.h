//
//  SHCategory.h
//  Stash
//
//  Created by Daniel Fairbanks on 5/29/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCategory : NSObject

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImage *iconImageHighlighted;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
