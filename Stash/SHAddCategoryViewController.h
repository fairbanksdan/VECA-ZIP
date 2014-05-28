//
//  SHAddCategoryViewController.h
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHAddCategoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *trashItButton;
@property (weak, nonatomic) IBOutlet UIButton *stashItButton;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *pitchTextView;
@property (weak, nonatomic) IBOutlet UIButton *pickCategoryButton;

@end
