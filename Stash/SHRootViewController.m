//
//  SHRootViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHRootViewController.h"
#import "SHHomeViewController.h"

@interface SHRootViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *bgScrollView, *fgScrollView;
@property (nonatomic, weak) UIViewController *activeViewController;
@end

@implementation SHRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_fgScrollView setContentOffset:CGPointMake(640, 0) animated:NO];
  
  SHHomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SHHomeViewController"];
  homeVC.view.backgroundColor = [UIColor yellowColor];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_fgScrollView])
    {
        [_bgScrollView setContentOffset:CGPointMake(_fgScrollView.contentOffset.x * 0.25, _fgScrollView.contentOffset.y) animated:NO];
    }
  
  
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_fgScrollView])
    {
        // call viewViewAppear for the destination View Controller
        NSInteger vcIndex = (NSInteger)(_fgScrollView.contentOffset.x / 320.f);
        if ([self.childViewControllers objectAtIndex:vcIndex]) {
            if ([_activeViewController isEqual:self.childViewControllers[vcIndex]]) {
                return;
            } else {
                _activeViewController = self.childViewControllers[vcIndex];
                [_activeViewController viewDidAppear:YES];                
            }
        }
    }

}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        [self addChildViewController:segue.destinationViewController];
    }
}
@end
