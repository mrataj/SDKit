//
//  BCLabel.h
//  Style
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
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *highlightedTextColor;
@property (nonatomic, retain) SDEvent *event;

- (CGSize)sizeForPoint:(CGPoint)point;

@end
