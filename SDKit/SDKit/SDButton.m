//
//  SDButton.m
//  SDKit
//
//  Created by Miha Rataj on 4.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDButton.h"
#import "SDHelper.h"
#import "SDEvent.h"

@implementation SDButton

@synthesize size=_size, event=_event, font=_font, textColor=_textColor, backgroundColor=_backgroundColor, text=_text, highlightedTextColor=_highlightedTextColor, highlightedBackgroundColor=_highlightedBackgroundColor;

- (id)init
{
    self = [super init];
    if (self)
    {
        _size = CGSizeMake(50, 24);
        _event = nil;
        _font = [UIFont boldSystemFontOfSize:14.0];
        _textColor = [UIColor whiteColor];
        _highlightedTextColor = [UIColor whiteColor];
        _backgroundColor = [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0];
        _highlightedBackgroundColor = [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:182.0/255.0 alpha:1.0];
        _text = nil;
    }
    return self;
}

- (UIColor *)getTextColor
{
    if (_highlighted && _event != nil)
        return _highlightedTextColor;
    
    return _textColor;
}

- (UIColor *)getBackgroundColor
{
    if (_highlighted && _event != nil)
        return _highlightedBackgroundColor;
    
    return _backgroundColor;
}

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw
{
    if (draw)
    {
        // Background
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [self getBackgroundColor].CGColor);
        CGRect buttonRect = CGRectMake(point.x, point.y, _size.width, _size.height);
        CGContextAddRoundedRect(context, buttonRect, 3.0);
        CGContextFillPath(context);
        
        // Text
        
        [[self getTextColor] set];
        CGRect textRect = CGRectMake(buttonRect.origin.x,
                                     point.y + floor(buttonRect.size.height / 2.0) - floor([_font ascender] / 2.0) - 2.0,
                                     buttonRect.size.width,
                                     [_font ascender]);
        [_text drawInRect:textRect
                 withFont:_font
            lineBreakMode:UILineBreakModeTailTruncation
                alignment:UITextAlignmentCenter];
    }
    
    return _size;
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    [_event performEvent];
}

@end
