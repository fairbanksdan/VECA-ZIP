//
//  SHBrowseIdeasViewController.m
//  Stash
//
//  Created by Reed Sweeney on 5/29/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHBrowseIdeasViewController.h"
#import "SHCollectionViewCell.h"

@interface SHBrowseIdeasViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *ideas;
-(void)fetchStashedIdeas;
@end

@implementation SHBrowseIdeasViewController

-(void)setIdeas:(NSArray *)ideas
{
  if (_ideas != ideas) {
    _ideas = ideas;
    [self.collectionView reloadData];
  }
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  [self fetchStashedIdeas];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)fetchStashedIdeas

{
//  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == "];
  NSArray *results = [SHStash findAllSortedBy:@"date" ascending:YES];
  self.ideas = results;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  
  return self.ideas.count;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
  SHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  SHStash *stash = self.ideas[indexPath.row];
  cell.ideaTitle.text = stash.title;
  NSLog(@"%@",[stash description]);
  cell.categoryImage.image = [UIImage imageNamed:@"biz-icon"];
  
  return cell;
  
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//
//{
//
//  
//}

@end
