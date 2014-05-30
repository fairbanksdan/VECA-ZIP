//
//  SHPitchTipsViewController.h
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHPitchTipsViewControllerDelegate <NSObject>

@end

@interface SHPitchTipsViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<SHPitchTipsViewControllerDelegate> delegate;

@end
