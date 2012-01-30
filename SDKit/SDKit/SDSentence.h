//
//  SDSentence.h
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

// Used for displaying sentences with clickable words.
// For example: Miha Rataj confirmed task to check to person Bostjan Bregar.
// Sentence is created with mutliple styled labels.

#import "SDControl.h"

@interface SDSentence : SDControl {
    CGFloat _maxWidth;
    CGFloat _maxHeight;
    BOOL _lastPunctation;
}

@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign) BOOL lastPunctation;
@property (nonatomic, readonly) BOOL hasHeightLimitation;
@property (nonatomic, readonly) BOOL hasWidthLimitation;

@end
