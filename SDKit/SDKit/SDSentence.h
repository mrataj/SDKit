//
//  SDSentence.h
//  SDKit
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDControl.h"
#import <CoreText/CoreText.h>

@class SDEvent;

@interface SDSentence : SDControl {
    CTFrameRef _ctFrame;
}

@property (nonatomic, strong) SDEvent *event;
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong) NSAttributedString *attributedString;
@property (nonatomic, readonly) BOOL hasHeightLimitation;
@property (nonatomic, readonly) BOOL hasWidthLimitation;
@property (nonatomic, strong) UIColor *backgroundColor;

@end
