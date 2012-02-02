//
//  BCLabel.m
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDLabel.h"
#import "SDEvent.h"

@implementation SDLabel

@synthesize text=_text, font=_font, textColor=_textColor, highlightedTextColor=_highlightedTextColor, event=_event;

- (id)init
{
    self = [super init];
    if (self)
    {
        _font = [[UIFont systemFontOfSize:12.0] retain];
        _textColor = [[UIColor blackColor] retain];
        _highlightedTextColor = [[UIColor blackColor] retain];
    }
    return self;
}

- (UIColor *)getColor
{
    if (_highlighted && _event != nil)
        return _highlightedTextColor;
    
    return _textColor;
}

- (CGSize)drawAtPoint:(CGPoint)point
{
    [[self getColor] set];
    CGSize size = [_text drawAtPoint:point withFont:_font];
    return [super createdAtPoint:point withSize:size];
}

- (CGSize)sizeForPoint:(CGPoint)point
{
    return [_text sizeWithFont:_font];
}

- (void)setText:(NSString *)text
{
    if (text == _text)
        return;
    
    [_text release];
    
    if ([text hasSuffix:@" "])
        _text = [text copy];
    else
        _text = [[NSString alloc] initWithFormat:@"%@ ", text];
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    [_event performEvent];
}

- (void)dealloc
{
    [_font release];
    [_text release];
    [_textColor release];
    [_highlightedTextColor release];
    [_event release];
    [super dealloc];
}

@end
