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

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw
{
    NSString *textToDraw = [_text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if (draw)
    {
        [[self getColor] set];
        return [textToDraw drawAtPoint:point withFont:_font];
    }
    else
    {
        return [textToDraw sizeWithFont:_font];
    }
}

- (NSInteger)numberOfLines
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\n"
                                                                           options:0
                                                                             error:nil];
    return [regex numberOfMatchesInString:_text options:0 range:NSMakeRange(0, [_text length])];
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
