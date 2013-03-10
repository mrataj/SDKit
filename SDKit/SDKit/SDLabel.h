//
//  SDLabel.h
//  SDKit
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDControl.h"

@class SDEvent;

@interface SDLabel : SDControl {
    NSString *_text;
    UIFont *_font;
    UIColor *_textColor;
    UIColor *_highlightedTextColor;
    SDEvent *_event;
    CGFloat _maxWidth;
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *highlightedTextColor;
@property (nonatomic, strong) SDEvent *event;
@property (nonatomic, readonly) NSInteger numberOfLines;
@property (nonatomic, assign) CGFloat maxWidth;

@end
