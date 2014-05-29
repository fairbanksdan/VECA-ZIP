//
//  SHCategory.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/29/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHCategory.h"

@implementation SHCategory

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    self.name = dict[@"category"];
    self.iconImage = [UIImage imageNamed:dict[@"imageName"]];
    self.iconImageHighlighted = [UIImage imageNamed:[NSString stringWithFormat:@"hover-%@", dict[@"imageName"]]];
    
    NSLog(@"Creating Category with name: %@ and image: %@", self.name, self.iconImage);
    return self;
}
@end
