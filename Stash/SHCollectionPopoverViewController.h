//
//  SHCollectionPopoverViewController.h
//  Stash
//
//  Created by Daniel Fairbanks on 5/28/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHCategory;

@protocol SHCollectionPopoverViewControllerDelegate <NSObject>

@optional

- (void)dismissPopoverWithCategory:(SHCategory *)category animated:(BOOL)animated;

@end

@interface SHCollectionPopoverViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<SHCollectionPopoverViewControllerDelegate> delegate;

@end
