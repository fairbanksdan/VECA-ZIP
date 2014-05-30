//
//  SHAddPitchViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddPitchViewController.h"
#import "UIImage+ImageEffects.h"

@interface SHAddPitchViewController () <UITextFieldDelegate>

@property (nonatomic, strong) SHPitchTipsViewController *popoverVC;
@property (nonatomic, strong) UIImageView *snapShotView;

- (void)didSaveToCoreData;
- (IBAction)trashStashButtonSelected:(id)sender;

@end

@implementation SHAddPitchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *color = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];

    _pitchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter the pitch for your idea here"
                                                                            attributes:@{NSForegroundColorAttributeName:color}];
    
    _pitchTextField.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    _pitchTextField.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2];

    
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
    [[[SHStashCloud sharedCloud]stash]setText:self.pitchTextField.text];
}

- (void)didSaveToCoreData
{
    self.pitchTextField.text = nil;
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

    _popoverVC.view.frame = CGRectMake(0, 0, 300, 420);
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

@end
