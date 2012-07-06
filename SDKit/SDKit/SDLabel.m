//
//  BCLabel.m
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDLabel.h"
#import "SDEvent.h"
#import "SDHelper.h"

@implementation SDLabel

@synthesize text=_text, font=_font, textColor=_textColor, highlightedTextColor=_highlightedTextColor, event=_event, maxWidth=_maxWidth;

- (id)init
{
    self = [super init];
    if (self)
    {
        _font = [[UIFont systemFontOfSize:12.0] retain];
        _textColor = [[UIColor blackColor] retain];
        _highlightedTextColor = [[UIColor blackColor] retain];
        _maxWidth = CGFLOAT_MAX;
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
        return [textToDraw drawAtPoint:point forWidth:_maxWidth withFont:_font lineBreakMode:UILineBreakModeTailTruncation];
    }
    else
    {
        return [textToDraw sizeWithFont:_font forWidth:_maxWidth lineBreakMode:UILineBreakModeTailTruncation];
    }
}

- (void)setText:(NSString *)text
{
    if (text == _text)
        return;
    
    [_text release];
    _text = [[text trim] retain];
}

- (NSInteger)numberOfLines
{
    if (_text == nil)
        return 0;
    
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
