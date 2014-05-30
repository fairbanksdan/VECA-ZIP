//
//  SHTitleTipsViewController.h
//  Stash
//
//  Created by Daniel Fairbanks on 5/30/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHTitleTipsViewControllerDelegate <NSObject>

@end

@interface SHTitleTipsViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<SHTitleTipsViewControllerDelegate> delegate;

@end
