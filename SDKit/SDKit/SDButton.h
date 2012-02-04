//
//  SDButton.h
//  SDKit
//
//  Created by Miha Rataj on 4.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDControl.h"

@class SDEvent;

@interface SDButton : SDControl {
    CGSize _size;
    SDEvent *_event;
    UIFont *_font;
    UIColor *_textColor;
    UIColor *_backgroundColor;
    UIColor *_highlightedBackgroundColor;
    UIColor *_highlightedTextColor;
    NSString *_text;
}

@property (nonatomic, assign) CGSize size;
@property (nonatomic, retain) SDEvent *event;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *highlightedBackgroundColor;
@property (nonatomic, retain) UIColor *highlightedTextColor;
@property (nonatomic, copy) NSString *text;

@end
