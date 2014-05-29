//
//  SHCategoryCollectionViewCell.h
//  Stash
//
//  Created by Daniel Fairbanks on 5/28/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCategory.h"

@interface SHCategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (nonatomic, weak) SHCategory *category;

@end
