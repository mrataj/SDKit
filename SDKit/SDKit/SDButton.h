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
@property (nonatomic, strong) SDEvent *event;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *highlightedBackgroundColor;
@property (nonatomic, strong) UIColor *highlightedTextColor;
@property (nonatomic, copy) NSString *text;

@end
