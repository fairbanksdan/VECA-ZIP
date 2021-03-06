//
//  SHAddPitchViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddPitchViewController.h"
#import "UIImage+ImageEffects.h"

@interface SHAddPitchViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) SHPitchTipsViewController *popoverVC;
@property (nonatomic, strong) UIImageView *snapShotView;

- (void)didSaveToCoreData;
- (IBAction)trashStashButtonSelected:(id)sender;

@end

@implementation SHAddPitchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    UIColor *color = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];

//    _pitchTextView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter the pitch for your idea here"
//                                                                            attributes:@{NSForegroundColorAttributeName:color}];
    
    _pitchTextView.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    _pitchTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2];
    
    if ([_projectNameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        _projectNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Project Name" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    if ([_taskLocationTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        _taskLocationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Specific Task Location" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    if ([_primaryEvacuationTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        _primaryEvacuationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Primary Evacuation" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    if ([_secondaryEvacuationTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        _secondaryEvacuationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Secondary Evacuation" attributes:@{NSForegroundColorAttributeName: color}];
    }
    
//new note
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSaveToCoreData) name:NSManagedObjectContextDidSaveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSaveToCoreData) name:kTrashStashButtonSelected object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[[SHStashCloud sharedCloud]stash]setText:self.pitchTextView.text];
}

- (void)didSaveToCoreData
{
    self.pitchTextView.text = nil;
}

- (IBAction)ProjectNameTextField:(id)sender {
    if ([_projectNameTextField becomeFirstResponder]) {
        _projectNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""];
        NSLog(@"Did it");
    }
}

- (IBAction)datePicker:(id)sender {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM dd, yyyy"];
    NSDate *date = _datePicker.date;
    NSString *dateSetString = [dateFormat stringFromDate:date];
    
    _dateLabel.text = dateSetString;
}

- (IBAction)trashStashButtonSelected:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kTrashStashButtonSelected object:nil];
}

- (IBAction)showHint:(id)sender
{
    
    
    _popoverVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverVC"];

    UIButton *dismissButton = [[UIButton alloc] initWithFrame:_popoverVC.view.bounds];
    
    [self.view addSubview:_popoverVC.view];
    [_popoverVC.view addSubview:dismissButton];

    _popoverVC.view.frame = CGRectMake(0, 0, 320, 568);
    _popoverVC.view.center = CGPointMake(self.view.center.x, self.view.center.y - 500);
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.0];
    
    _snapShotView = [SHAddPitchViewController snapshotForView:self.view.superview.superview.superview];
    _snapShotView.alpha = 0.f;
    
    [self.view addSubview:_snapShotView];
    [self.view addSubview:_popoverVC.view];
    
    [UIView animateWithDuration:0.4
                          delay:0.f
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _popoverVC.view.center = self.view.center;
                         _snapShotView.alpha = 1.f;
                     } completion:^(BOOL finished) {
                         _popoverVC.delegate = self;
                         
                     }];
    [dismissButton addTarget:self action:@selector(dismissPopover:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissPopover:(id)sender
{    
    [UIView animateWithDuration:0.8
                          delay:0.f
         usingSpringWithDamping:1.f
          initialSpringVelocity:1.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _popoverVC.view.center = CGPointMake(self.view.center.x, self.view.frame.size.height*2);
                         _snapShotView.alpha = 0.f;
                     } completion:^(BOOL finished) {
                         _popoverVC.delegate = nil;
                         [_popoverVC.view removeFromSuperview];
                         [_snapShotView removeFromSuperview];
                         _snapShotView = nil;
                         _popoverVC = nil;
                     }];
}

//Takes a snapshot of the View and adds a smoked glass window effect. Changing the "applyBlurWithRadius will change the how much the image is blured. 
+ (UIImageView *)snapshotForView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *snapShotView = [[UIImageView alloc] initWithFrame:view.frame];
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.05];
    snapShotView.image = [snapshotImage applyBlurWithRadius:8 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    return snapShotView;
}
- (IBAction)tapGesture:(id)sender {
    [_projectNameTextField resignFirstResponder];
    [_taskLocationTextField resignFirstResponder];
    [_primaryEvacuationTextField resignFirstResponder];
    [_secondaryEvacuationTextField resignFirstResponder];
    
}

@end
