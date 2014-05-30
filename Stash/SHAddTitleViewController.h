//
//  SHAddTitleViewController.h
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHTitleTipsViewController.h"

@interface SHAddTitleViewController : UIViewController <SHTitleTipsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *trashItButton;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *pitchTextView;
@property (weak, nonatomic) IBOutlet UIButton *titleTipsHelpButton;

@end
