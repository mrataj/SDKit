//
//  BCFeedCell.h
//  Example
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDKit.h"
#import "BCFeedCellDelegate.h"

@class BBSentence;
@class BBCodeString;

@interface BCFeedCell : SDTableViewCell

@property (nonatomic, strong) BBSentence *sentence;
@property (nonatomic, strong) SDImageView *image;
@property (nonatomic, weak) id<BCFeedCellDelegate> delegate;

+ (CGFloat)heightForBbCode:(BBCodeString *)code andWidth:(CGFloat)width;

@end
