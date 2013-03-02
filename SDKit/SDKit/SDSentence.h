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
// IMPORTANT! Never set BBCode when drawing parent control, always before!

#import "SDControl.h"
#import "SDSentenceBuilder.h"
#import "SDSentenceLayout.h"

@interface SDSentence : SDControl {
    CGFloat _maxWidth;
    CGFloat _maxHeight;
    NSString *_BBCode;
    SDSentenceLayout *_layout;
}

- (id)initWithLayout:(SDSentenceLayout *)layout;

@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, copy) NSString *BBCode;
@property (nonatomic, strong) SDSentenceLayout *layout;
@property (nonatomic, readonly) BOOL hasHeightLimitation;
@property (nonatomic, readonly) BOOL hasWidthLimitation;

@end
