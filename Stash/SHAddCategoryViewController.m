//
//  SHAddCategoryViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHAddCategoryViewController.h"
#import "SHStash+Manage.h"
#import "SHCategory.h"
#import "UIImage+ImageEffects.h"

@interface SHAddCategoryViewController ()

@property (nonatomic, strong) SHCollectionPopoverViewController *popoverVC;
@property (nonatomic, strong) UIImageView *snapShotView;

- (IBAction)stashITButtonSelected:(UIButton *)sender;
- (IBAction)trashStashButtonSelected:(id)sender;

@end

@implementation SHAddCategoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.titleTextLabel setText:[[[SHStashCloud sharedCloud]stash]title]];
    [self.pitchTextView setText:[[[SHStashCloud sharedCloud]stash]text]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Action Methods

- (IBAction)stashITButtonSelected:(UIButton *)sender
{
    if ([[[[SHStashCloud sharedCloud]stash]title]length] && [[[[SHStashCloud sharedCloud]stash]text]length]) {
        [[[SHStashCloud sharedCloud]stash]saveStash];
        [[[SHStashCloud sharedCloud]stash]setTitle:nil];
        [[[SHStashCloud sharedCloud]stash]setText:nil];
    } else {
        [[[UIAlertView alloc]initWithTitle:@"Hold on..."
                                   message:@"You need to have both the title and the idea text entered before you can save."
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil, nil]show];
    }
}

- (IBAction)trashStashButtonSelected:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kTrashStashButtonSelected object:nil];
}

- (IBAction)showCategoryPopover:(id)sender {
    _popoverVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverCategoryVC"];
    _popoverVC.view.frame = CGRectMake(0, 0, 300, 420);
    _popoverVC.view.center = CGPointMake(self.view.center.x, self.view.center.y - 500);
    self.view.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.0];
    
    _snapShotView = [SHAddCategoryViewController snapshotForView:self.view.superview.superview.superview];
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
    
}


#pragma mark - SHAddCategoryViewControllerDelegate

- (void)dismissPopoverWithCategory:(SHCategory *)category animated:(BOOL)animated
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
                         
                         // Setting the category for the stash.
                         [[[SHStashCloud sharedCloud]stash]setCategory:category.name];
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
