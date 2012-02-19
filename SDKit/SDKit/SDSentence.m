//
//  BCSentence.m
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDSentence.h"
#import "SDHelper.h"
#import "SDLabel.h"

@implementation SDSentence

@synthesize maxWidth=_maxWidth, maxHeight=_maxHeight, BBCode=_BBCode, layout=_layout;

- (id)initWithLayout:(SDSentenceLayout *)layout
{
    self = [super init];
    if (self)
    {
        self.layout = layout;
    }
    return self;
}

- (void)createLabel:(NSString *)text afterLabel:(SDLabel *)label
{
    // TODO: Do this with NSCopying
    SDLabel *nextLabel = [[SDLabel alloc] init];
    [nextLabel setFont:label.font];
    [nextLabel setText:text];            
    [nextLabel setEvent:label.event];
    [nextLabel setTextColor:label.textColor];
    [nextLabel setTouchInset:label.touchInset];
    [nextLabel setHighlightedTextColor:label.highlightedTextColor];
    [nextLabel setPreviousControl:label];
    [_items insertObject:nextLabel atIndex:[_items indexOfObject:label] + 1];
    [nextLabel release];
}

- (NSArray *)createSentence:(NSArray *)items
{
    NSMutableArray *labels = [NSMutableArray array];
    
    
    
    return labels;
}

- (CGSize)resize:(CGSize)size toFit:(CGRect)frame forDrawAt:(CGPoint)point
{
    CGPoint endpoint = CGEndpointFromCGRect(frame);
    if (endpoint.x - point.x > size.width)
        size = CGSizeMake(endpoint.x - point.x, size.height);
    if (endpoint.y - point.y > size.height)
        size = CGSizeMake(size.width, endpoint.y - point.y);
    return size;
}

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw
{
    CGPoint coordinate = point;
    CGSize size = CGSizeZero;
    
    NSArray *items = [self createSentence:_items];
    for (NSInteger i = 0; i < [items count]; i++)
    {        
        SDLabel *label = [items objectAtIndex:i];
        if (![label isKindOfClass:[SDLabel class]])
            continue;
        
        if (self.hasWidthLimitation)
        {
            
        }
        
        if (self.hasHeightLimitation)
        {
            
        }
        
        CGSize itemSize = (!draw) ? [label sizeForPoint:coordinate] : [label drawAtPoint:coordinate];
        CGRect frame = CGRectMake(coordinate.x, coordinate.y, itemSize.width, itemSize.height);
        size = [self resize:size toFit:frame forDrawAt:point];
    }
    
    return CGSizeRound(size);
}

- (void)setBBCode:(NSString *)BBCode
{
    if (BBCode == _BBCode)
        return;
    
    [_BBCode release];
    _BBCode = [BBCode retain];
    
    SDSentenceBuilder *sb = [[SDSentenceBuilder alloc] initWithCode:_BBCode];
    [sb setLayout:_layout];
    [sb build];
    [self setItems:sb.labels];
    [sb release];
}

- (BOOL)hasHeightLimitation
{
    return _maxHeight > 0;
}

- (BOOL)hasWidthLimitation
{
    return _maxWidth > 0;
}

- (void)dealloc
{
    [_layout release];
    [_BBCode release];
    [super dealloc];
}

@end
