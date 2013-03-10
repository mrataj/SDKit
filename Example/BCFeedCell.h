//
//  BCFeedCell.h
//  Example
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDKit.h"
#import "BCFeedCellDelegate.h"

@interface BCFeedCell : SDTableViewCell

@property (nonatomic, strong) SDSentence *sentence;
@property (nonatomic, strong) SDImageView *image;
@property (nonatomic, weak) id<BCFeedCellDelegate> delegate;

+ (CGFloat)heightForAttributedString:(NSAttributedString *)string andWidth:(CGFloat)width;

@end
