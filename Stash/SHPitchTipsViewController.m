//
//  SHPitchTipsViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/27/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHPitchTipsViewController.h"

@interface SHPitchTipsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *PitchTipsLabel;

@end

@implementation SHPitchTipsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];    
    _PitchTipsLabel.textAlignment = UITextLayoutDirectionUp;
}

@end
