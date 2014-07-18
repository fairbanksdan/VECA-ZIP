//
//  SHAddPitchViewController.h
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHPitchTipsViewController.h"

@interface SHAddPitchViewController : UIViewController <SHPitchTipsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *trashItButton;
@property (weak, nonatomic) IBOutlet UIButton *pitchTipsHelpButton;
@property (weak, nonatomic) IBOutlet UITextView *pitchTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *taskLocationTextField;
@property (strong, nonatomic) IBOutlet UITextField *primaryEvacuationTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondaryEvacuationTextField;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

@end
