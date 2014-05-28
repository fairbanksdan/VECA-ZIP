//
//  SHCollectionPopoverViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/28/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHCollectionPopoverViewController.h"
#import "SHCategoryCollectionViewCell.h"

@interface SHCollectionPopoverViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SHCollectionPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
//    User *user = self.userArray[indexPath.row];
//    if (user.avatarImage)
//    {
//        
//        cell.imageView.image = user.avatarImage;
//    } else {
//        cell.imageView.image = [UIImage imageNamed:@"GitHub-Mark"];
//        [user downloadAvatarOnQueue:_imageQueue withCompletionBlock:^{
//            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
//        }];
//    }
//    
//    cell.cellLabel.text = [self.userArray[indexPath.row] name];
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
