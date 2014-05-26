//
//  SHStash.h
//  Stash
//
//  Created by Reed Sweeney on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SHStash : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * stashID;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSNumber * isMine;

@end
