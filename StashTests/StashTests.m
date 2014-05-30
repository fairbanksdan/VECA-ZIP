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

- (void)testIfUserCanScroll
{
    XCTAssertNotNil(_rootVC.bgScrollView, @"Background scrollview should not be nil");
}
@end
