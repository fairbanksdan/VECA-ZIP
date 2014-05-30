//
//  StashTests.m
//  StashTests
//
//  Created by Taylor Potter on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHRootViewController.h"

@interface StashTests : XCTestCase
@property (nonatomic, strong) SHRootViewController *rootVC;
@end

@implementation StashTests

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"iPhone568" bundle:nil];
    self.rootVC = [storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
    [self.rootVC performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIfScrollViewIsNil
{
    XCTAssertNotNil(_rootVC.bgScrollView, @"Background scrollview should not be nil");
}

- (void)testCanUserScroll
{
    NSArray *results = [SHStash findAllSortedBy:@"date" ascending:YES];
    if (results.count) {
        XCTAssertTrue(_rootVC.fgScrollView.userInteractionEnabled, @"View must allow user to scroll right or press browse button as long as at least 1 idea has been saved");
    } else {
        XCTAssertFalse(_rootVC.fgScrollView.userInteractionEnabled, @"View must allow user to scroll right or press browse button as long as at least 1 idea has been saved");
    }
}
@end
