//
//  SHAddTitleViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddTitleViewController.h"
#import "UIImage+ImageEffects.h"

@interface SHAddTitleViewController ()

@property (nonatomic, strong) SHTitleTipsViewController *popoverVC;
@property (nonatomic, strong) UIImageView *snapShotView;

- (void)didSaveToCoreData;
- (IBAction)trashStashButtonSelected:(id)sender;

@end

@implementation SHAddTitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.titleTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.7];
        self.titleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter title..." attributes:@{NSForegroundColorAttributeName: color}];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pitchTextView setText:[[[SHStashCloud sharedCloud]stash]text]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSaveToCoreData) name:NSManagedObjectContextDidSaveNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[[SHStashCloud sharedCloud]stash]setTitle:self.titleTextField.text];
}

- (void)didSaveToCoreData
{
    self.titleTextField.text = nil;
    self.pitchTextView.text = nil;
}

- (IBAction)trashStashButtonSelected:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kTrashStashButtonSelected object:nil];
}

- (IBAction)showHint:(id)sender {
//    
//    UIViewController *popover = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverTitleVC"];
//    popover.view.bounds = CGRectMake(0, 0, 260, 300);
//    popover.view.center = self.view.center;
//    popover.view.alpha = 0.f;
//    UIButton *dismissButton = [[UIButton alloc] initWithFrame:popover.view.bounds];
//    
//    //    popover.view.center = CGPointMake(self.view.center.x, self.view.frame.size.height);
//    
//    [self.view addSubview:popover.view];
//    [popover.view addSubview:dismissButton];
//    [dismissButton addTarget:self action:@selector(dismissPopover:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [UIView animateWithDuration:0.4
//                     animations:^{
//                         //                         popover.view.center = self.view.center;
//                         popover.view.alpha = 1.f;
//                     }];
    
    _popoverVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverTitleVC"];
    
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:_popoverVC.view.bounds];
    
    [self.view addSubview:_popoverVC.view];
    [_popoverVC.view addSubview:dismissButton];
    
    _popoverVC.view.frame = CGRectMake(0, 0, 320, 568);
    _popoverVC.view.center = CGPointMake(self.view.center.x, self.view.center.y - 500);
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.0];
    
    _snapShotView = [SHAddTitleViewController snapshotForView:self.view.superview.superview.superview];
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
//    UIView *popoverView = [(UIButton *)sender superview];
//    [UIView animateWithDuration:0.4
//                     animations:^{
//                         popoverView.alpha = 0.f;
//                     } completion:^(BOOL finished) {
//                         [popoverView removeFromSuperview];
//                     }];
    
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
