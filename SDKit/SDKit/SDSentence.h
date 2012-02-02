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
#import "BBCodeParser.h"

@interface SDSentence : SDControl <BBCodeParserDelegate> {
    CGFloat _maxWidth;
    CGFloat _maxHeight;
    NSString *_BBCode;
}

@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, copy) NSString *BBCode;
@property (nonatomic, readonly) BOOL hasHeightLimitation;
@property (nonatomic, readonly) BOOL hasWidthLimitation;

@end
