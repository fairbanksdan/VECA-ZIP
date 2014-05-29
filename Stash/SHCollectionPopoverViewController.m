//
//  SHCollectionPopoverViewController.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/28/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHCollectionPopoverViewController.h"
#import "SHCategoryCollectionViewCell.h"
#import "SHCategory.h"

@interface SHCollectionPopoverViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *icons;
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

    _icons = [NSMutableArray new];
    
    NSMutableArray *plistIcons = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IconPList" ofType:@"plist"]];

    for (NSDictionary *icon in plistIcons) {
        SHCategory *category = [[SHCategory alloc] initWithDictionary:icon];
        [_icons addObject:category];
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _icons.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.category = _icons[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate dismissPopoverWithCategory:_icons[indexPath.row] animated:YES];
}
@end
