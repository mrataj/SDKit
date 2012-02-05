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
        _font = [[UIFont boldSystemFontOfSize:14.0] retain];
        _textColor = [[UIColor whiteColor] retain];
        _highlightedTextColor = [[UIColor whiteColor] retain];
        _backgroundColor = [[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0] retain];
        _highlightedBackgroundColor = [[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:182.0/255.0 alpha:1.0] retain];
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

- (CGPoint)getEndpointForDrawingAtPoint:(CGPoint)point doDrawing:(BOOL)drawing
{
    if (drawing)
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
    
    return CGPointMake(_size.width, _size.height);
}

- (CGSize)drawAtPoint:(CGPoint)point
{
    CGPoint endpoint = [self getEndpointForDrawingAtPoint:point doDrawing:YES];    
    return [self createdAtPoint:point withSize:CGSizeMakeFromPoint(endpoint)];
}

- (CGSize)sizeForPoint:(CGPoint)point
{
    CGPoint endpoint = [self getEndpointForDrawingAtPoint:point doDrawing:NO];
    return CGSizeMakeFromPoint(endpoint);
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    [_event performEvent];
}

- (void)dealloc
{
    [_event release];
    [_font release];
    [_textColor release];
    [_backgroundColor release];
    [_highlightedTextColor release];
    [_highlightedBackgroundColor release];
    [_text release];
    [super dealloc];
}
@end
