//
//  SHCategoryCollectionViewCell.m
//  Stash
//
//  Created by Daniel Fairbanks on 5/28/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

#import "SHCategoryCollectionViewCell.h"

@implementation SHCategoryCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCategory:(SHCategory *)category
{
    _category = category;
    _iconImageView.image = _category.iconImage;
    _iconImageView.highlightedImage = _category.iconImageHighlighted;
    _iconLabel.text = _category.name;
}

@end
