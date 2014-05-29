//
//  SHRootViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHRootViewController.h"
#import "SHEditViewController.h"
#import "SHBrowseIdeasViewController.h"
#import "SHHomeViewController.h"
#import "SHAddPitchViewController.h"
#import "SHAddTitleViewController.h"
#import "SHAddCategoryViewController.h"

@interface SHRootViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIStoryboard *storyBoard;
@property (nonatomic, weak) IBOutlet UIScrollView *bgScrollView, *fgScrollView;
@property (weak, nonatomic) IBOutlet UIView *editVCContainer;
@property (nonatomic, strong) SHEditViewController *editViewController;
@property (weak, nonatomic) IBOutlet UIView *browseVCContainer;
@property (nonatomic, strong) SHBrowseIdeasViewController *browseIdeasViewController;
@property (weak, nonatomic) IBOutlet UIView *homeVCContainer;
@property (nonatomic, strong) SHHomeViewController *homeViewController;
@property (weak, nonatomic) IBOutlet UIView *addPitchVCContainer;
@property (nonatomic, strong) SHAddPitchViewController *addPitchViewController;
@property (weak, nonatomic) IBOutlet UIView *addTitleVCContainer;
@property (nonatomic, strong) SHAddTitleViewController *addTitleViewController;
@property (weak, nonatomic) IBOutlet UIView *addCategoryVCContainer;
@property (nonatomic, strong) SHAddCategoryViewController *addCategoryViewController;

- (void)returnToHomeView;
- (void)trashStash;

@end

@implementation SHRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.storyBoard = [UIStoryboard storyboardWithName:@"iPhone568" bundle:nil];
    
    [self setupInitialViewControllers];
    
    [_fgScrollView setContentOffset:CGPointMake(640, 0) animated:NO];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(returnToHomeView) name:NSManagedObjectContextDidSaveNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addNewStash) name:kAddStashButtonSelected object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(trashStash) name:kTrashStashButtonSelected object:nil];
}

-(void)setupInitialViewControllers
{
    self.editViewController = [self.storyBoard instantiateViewControllerWithIdentifier:@"SHEditViewController"];
    self.editViewController.view.frame = self.editVCContainer.frame;
    [self.editVCContainer addSubview:self.editViewController.view];
    [self addChildViewController:self.editViewController];
    [self.editViewController didMoveToParentViewController:self];
    
    self.browseIdeasViewController = [self.storyBoard instantiateViewControllerWithIdentifier:@"SHBrowseIdeasViewController"];
    self.browseIdeasViewController.view.frame = self.browseVCContainer.frame;
    [self.browseVCContainer addSubview:self.browseIdeasViewController.view];
    [self addChildViewController:self.browseIdeasViewController];
    [self.browseIdeasViewController didMoveToParentViewController:self];
    
    self.homeViewController = [self.storyBoard instantiateViewControllerWithIdentifier:@"SHHomeViewController"];
    self.homeViewController.view.frame = self.homeVCContainer.frame;
    [self.homeVCContainer addSubview:self.homeViewController.view];
    [self addChildViewController:self.homeViewController];
    [self.homeViewController didMoveToParentViewController:self];

    self.addPitchViewController = [self.storyBoard instantiateViewControllerWithIdentifier:@"SHAddPitchViewController"];
    self.addPitchViewController.view.frame = self.addPitchVCContainer.frame;
    [self.addPitchVCContainer addSubview:self.addPitchViewController.view];
    [self addChildViewController:self.addPitchViewController];
    [self.addPitchViewController didMoveToParentViewController:self];
    
    self.addTitleViewController = [self.storyBoard instantiateViewControllerWithIdentifier:@"SHAddTitleViewController"];
    self.addTitleViewController.view.frame = self.addTitleVCContainer.frame;
    [self.addTitleVCContainer addSubview:self.addTitleViewController.view];
    [self addChildViewController:self.addTitleViewController];
    [self.addTitleViewController didMoveToParentViewController:self];
    
    self.addCategoryViewController = [self.storyBoard instantiateViewControllerWithIdentifier:@"SHAddCategoryViewController"];
    self.addCategoryViewController.view.frame = self.addCategoryVCContainer.frame;
    [self.addCategoryVCContainer addSubview:self.addCategoryViewController.view];
    [self addChildViewController:self.addCategoryViewController];
    [self.addCategoryViewController didMoveToParentViewController:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_fgScrollView])
    {
        [_bgScrollView setContentOffset:CGPointMake(_fgScrollView.contentOffset.x * 0.25, _fgScrollView.contentOffset.y) animated:NO];
    }
    
//    NSLog(@" %f",scrollView.contentOffset.x);
    
    //resigns pitch textfield when scrolling on addPitchVC
    if (scrollView.contentOffset.x < 950 && scrollView.contentOffset.x > 860)
    {
        [self.addPitchViewController.pitchTextField resignFirstResponder];
    }
    
    if (scrollView.contentOffset.x < 1380 && scrollView.contentOffset.x > 1290)
    {
        [self.addTitleViewController.titleTextField resignFirstResponder];
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    switch ((int) scrollView.contentOffset.x) {
        case SH_EDIT_VIEW_CONTROLLER:
            [self.editViewController viewDidAppear:YES];
            [self.browseIdeasViewController viewDidDisappear:YES];
            break;
            
        case SH_BROWSE_VIEW_CONTROLLER:
            [self.editViewController viewDidDisappear:YES];
            [self.browseIdeasViewController viewDidAppear:YES];
            [self.homeViewController viewDidDisappear:YES];
            break;
            
        case SH_HOME_VIEW_CONTROLLER:
            [self.browseIdeasViewController viewDidDisappear:YES];
            [self.homeViewController viewDidAppear:YES];
            [self.addPitchViewController viewDidDisappear:YES];
            break;
            
        case SH_ADD_PITCH_VIEW_CONTROLLER:
            [self.homeViewController viewDidDisappear:YES];
            [self.addPitchViewController viewDidAppear:YES];
            [self.addTitleViewController viewDidDisappear:YES];
            [self.addPitchViewController.pitchTextField becomeFirstResponder];
            break;
            
        case SH_ADD_TITLE_VIEW_CONTROLLER:
            [self.addPitchViewController viewDidDisappear:YES];
            [self.addTitleViewController viewDidAppear:YES];
            [self.addCategoryViewController viewDidDisappear:YES];
            [self.addTitleViewController.titleTextField becomeFirstResponder];
            break;
            
        case SH_ADD_CATEGORY_VIEW_CONTROLLER:
            [self.addTitleViewController viewDidDisappear:YES];
            [self.addCategoryViewController viewDidAppear:YES];
            break;
            
        default:
            break;
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Notifications

- (void)returnToHomeView
{
    [self.fgScrollView setContentOffset:CGPointMake(SH_HOME_VIEW_CONTROLLER, 0.0) animated:YES];
}

- (void)addNewStash
{
    [self.fgScrollView setContentOffset:CGPointMake(SH_ADD_PITCH_VIEW_CONTROLLER, 0.0) animated:YES];
    
    dispatch_queue_t waiQ = dispatch_queue_create("waitQ", NULL);
    dispatch_async(waiQ, ^{
        usleep(400000);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.addPitchViewController.pitchTextField becomeFirstResponder];
        });
    });
}

- (void)trashStash
{
    [[[SHStashCloud sharedCloud]stash]setTitle:nil];
    [[[SHStashCloud sharedCloud]stash]setText:nil];
    [self returnToHomeView];
}

@end
