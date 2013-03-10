//
//  BCFeedCellDelegate.h
//  Example
//
//  Created by Miha Rataj on 3.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BCFeedCell;
@class SDSentenceTouchEventArgument;

@protocol BCFeedCellDelegate <NSObject>

- (void)cell:(BCFeedCell *)cell sentenceTouched:(SDSentenceTouchEventArgument *)eventArgument;

@end
