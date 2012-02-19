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

- (SDLabel *)createLabel:(NSString *)text afterLabel:(SDLabel *)label
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
    return [nextLabel autorelease];
}

- (NSArray *)extractNewLinesFrom:(NSArray *)items
{
    NSMutableArray *labels = [NSMutableArray array];
    
    for (SDLabel *label in items)
    {
        if (![label isKindOfClass:[SDLabel class]])
            continue;
        
        // Create new labels for new lines.
        NSArray *components = [label.text componentsSeparatedByString:@"\n" includeSeparator:YES];
        [label setText:[components objectAtIndex:0]];
        [labels addObject:label];
        
        for (NSInteger i = 1; i < [components count]; i++)
        {
            SDLabel *nextLabel = [self createLabel:[components objectAtIndex:i] afterLabel:label];
            [labels addObject:nextLabel];
        }
    }
    
    return labels;
}

- (void)splitText:(NSString *)text withLabel:(SDLabel *)label
{
    NSArray *lines = [text componentsSeparatedByString:@"\n" includeSeparator:YES];
    [label setText:[lines objectAtIndex:0]];
    
    for (NSInteger i = 1; i < [lines count]; i++)
    {
        SDLabel *nextLabel = [self createLabel:[lines objectAtIndex:i] afterLabel:label];
        [_items insertObject:nextLabel atIndex:[_items indexOfObject:label] + 1];
    }
}

- (void)doCharacterWrap:(SDLabel *)label
{
    NSMutableString *original = [NSMutableString stringWithString:label.text];
    NSMutableString *ms = [NSMutableString string];
    for (int i = 0; i < [original length] - 1; i++)
    {
        [ms appendString:[original substringWithRange:NSMakeRange(i, 1)]];
        [label setText:ms];
        
        CGSize expected = [label sizeForPoint:CGPointZero];
        if (expected.width > _maxWidth)
        {
            [original replaceCharactersInRange:NSMakeRange(i - 1, 0) withString:@"\n"];
            [self splitText:original withLabel:label];
            return;
        }
    }
}

- (void)doWordWrap:(SDLabel *)label
{
    NSMutableString *original = [NSMutableString stringWithString:label.text];
    NSMutableString *ms = [NSMutableString string];
    NSInteger length = 0;
    
    NSArray *components = [label.text componentsSeparatedByString:@" " includeSeparator:YES];
    for (NSString *component in components)
    {
        [ms appendString:component];
        [label setText:ms];
        
        CGSize expected = [label sizeForPoint:CGPointZero];
        if (expected.width > _maxWidth)
        {
            [label setText:component];
            expected = [label sizeForPoint:CGPointZero];
            
            // If whole word is longer than _maxWidth, do character wrap.
            if (expected.width > _maxWidth)
            {
                [ms setString:@""];
                for (int i = [components indexOfObject:component]; i < [components count]; i++)
                    [ms appendString:[components objectAtIndex:i]];
                
                [label setText:ms];
                [self doCharacterWrap:label];
            }
            else
            {
                [original replaceCharactersInRange:NSMakeRange(length, 1) withString:@"\n"];
                [self splitText:original withLabel:label];
            }
            
            return;
        }
        
        length = [ms length];
    }
}

- (void)wrapLabel:(SDLabel *)label mode:(UILineBreakMode)mode
{
    switch (mode)
    {
        case UILineBreakModeCharacterWrap:
            [self doCharacterWrap:label];
            break;
        case UILineBreakModeWordWrap:
            [self doWordWrap:label];
            break;
        default:
            @throw [NSException exceptionWithName:@"Not supported." reason:@"Not supported line break mode." userInfo:nil];
    }
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
    
    for (int i = 0; i < [self.items count]; i++)
    {
        SDLabel *item = [self.items objectAtIndex:i];
        if (![item isKindOfClass:[SDLabel class]])
            continue;
        
        CGFloat topMargin = [item numberOfLines] * [item.font lineHeight];
        coordinate = CGPointMake(coordinate.x, coordinate.y + topMargin);
        
        if (self.hasWidthLimitation)
        {
            CGSize expected = [item sizeForPoint:coordinate];
            if (expected.width > _maxWidth)
                [self wrapLabel:item mode:UILineBreakModeWordWrap];
        }
        
        if (self.hasHeightLimitation)
        {
            CGSize expected = [item sizeForPoint:coordinate];
            if (expected.height > _maxHeight)
                break;
        }
                
        CGSize itemSize = (!draw) ? [item sizeForPoint:coordinate] : [item drawAtPoint:coordinate];
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

- (void)setItems:(NSArray *)items
{
    [super setItems:[self extractNewLinesFrom:items]];
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
