//
//  SHCollectionViewCell.h
//  Stash
//
//  Created by Taylor Potter on 5/29/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *ideaTitle;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;


@end
