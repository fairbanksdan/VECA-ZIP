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

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
