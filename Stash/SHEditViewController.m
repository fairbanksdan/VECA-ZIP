//
//  SHEditViewController.m
//  Stash
//
//  Created by iC on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHEditViewController.h"
#import "SHStash.h"
#import "SHStashAPI.h"

@interface SHEditViewController ()

- (IBAction)shareButtonSelected:(id)sender;

@end

@implementation SHEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Methods

- (IBAction)shareButtonSelected:(id)sender
{
    // This data derives from the actual stash.
    NSString *text = @"Hi, just need your opinion on something. Check out my idea on stash.";
    NSString *stashAppLink = @"Download Stash on the app store bit.ly/1hvvtAG";
    NSString *stashUUID = [[[[[NSUUID UUID]UUIDString]lowercaseString]stringByReplacingOccurrencesOfString:@"-" withString:@""]substringToIndex:12];
    NSString *stashLink = [NSString stringWithFormat:@"Stash://?id=%@", stashUUID];
    NSString *message = [NSString stringWithFormat:@"%@\n\n%@\n\n%@", text, stashLink, stashAppLink];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[message] applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePrint,
                                                     UIActivityTypeCopyToPasteboard,
                                                     UIActivityTypeAssignToContact,
                                                     UIActivityTypeSaveToCameraRoll,
                                                     UIActivityTypeAddToReadingList,
                                                     UIActivityTypePostToFlickr,
                                                     UIActivityTypePostToVimeo];
    activityViewController.completionHandler = ^(NSString *activityType, BOOL complete) {
        if ([activityType isEqualToString:UIActivityTypeMessage]) {
            [self performPOSTRequestForStash:nil]; // sends the stash object to be uploaded to our server upon messages VC dismissal.
        }
    };
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)performPOSTRequestForStash:(SHStash *)stash
{
    [[SHStashAPI sharedAPI]POSTRequestForStashWithTitle:@"New Stash" // self.stash.title
                                                   text:@"Here is a new stash." // self.stash.text
                                                   uuid:[[[[[NSUUID UUID]UUIDString]lowercaseString]stringByReplacingOccurrencesOfString:@"-" withString:@""]substringToIndex:12]
                                             completion:^(NSError *error) {
                                                 NSLog(@"Stash uploaded...");
                                             }];
}

@end
