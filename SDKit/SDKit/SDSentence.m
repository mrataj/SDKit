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

- (NSString *)divideWithCharactersWrap:(SDLabel *)label forDrawingAt:(CGPoint)coordinate
{
    for (NSInteger j = 1; j < [label.text length] + 1; j++)
    {
        NSString *trimmed = [label.text substringToIndex:j];
        
        [label setText:trimmed];
        CGSize size = [label sizeForPoint:CGPointZero];
        
        BOOL exceed = (coordinate.x + size.width > _maxWidth);
        if (exceed)
        {
            NSString *currentWord = [label.text substringToIndex:j - 1];
            NSString *nextWord = [label.text substringFromIndex:j - 1];
            return [NSString stringWithFormat:@"%@\n%@", [currentWord trim], [nextWord trim]];
        }
    }
    
    // Only if text does not exceed width.
    return [label.text trim];
}

- (NSString *)divideWithWordWrap:(SDLabel *)label forDrawingAt:(CGPoint)coordinate
{
    NSMutableString *mutable = [NSMutableString string];
    
    NSArray *words = [label.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSString *word in words)
    {
        [mutable appendWord:word withSpace:[words indexOfObject:word] + 1 != [words count]];
        [label setText:mutable];
        CGSize size = [label sizeForPoint:CGPointZero];
        
        BOOL exceed = (coordinate.x + size.width > _maxWidth);
        if (exceed)
        {
            // If first word is longer than _maxWidth, do character wrap, because word wrap is impossible in that case.
            if ([mutable isEqualToString:word] && size.width > _maxWidth)
            {
                return [self divideWithCharactersWrap:label forDrawingAt:coordinate];
            }
            else
            // Otherwise, do word wrap.
            {
                // Text which will fill current line.
                NSMutableString *currentWord = [NSMutableString string];
                for (NSInteger j = 0; j < [words indexOfObject:word]; j++)
                    [currentWord appendWord:[words objectAtIndex:j] withSpace:j + 1 != [words indexOfObject:word]];
                
                // The rest of the text (for new line)
                NSMutableString *nextWord = [NSMutableString string];
                for (NSInteger j = [words indexOfObject:word]; j < [words count]; j++)
                    [nextWord appendWord:[words objectAtIndex:j] withSpace:j + 1 != [words count]];
                
                return [NSString stringWithFormat:@"%@\n%@", [currentWord trim], [nextWord trim]];
            }
        }
    }
    
    // Only if text does not exceed width.
    return [label.text trim];
}

- (NSString *)divideLabel:(SDLabel *)label forDrawingAt:(CGPoint)coordinate lineBreakMode:(UILineBreakMode)mode
{
    switch (mode)
    {
        case UILineBreakModeWordWrap:
            return [self divideWithWordWrap:label forDrawingAt:coordinate];
        case UILineBreakModeCharacterWrap:
            return [self divideWithCharactersWrap:label forDrawingAt:coordinate];
        default:
            @throw [NSException exceptionWithName:@"Not supported line break mode." reason:@"This line break mode isn't yet supported." userInfo:nil];
    }
}

- (BOOL)splitLabel:(SDLabel *)label byComponents:(NSArray *)components coordinate:(CGPoint *)coordinate point:(CGPoint)point
{
    NSString *part1 = [components objectAtIndex:0];
    [label setText:part1];
    
    if ([components count] > 1)
    {
        NSString *part2 = [components objectAtIndex:1];
        if ([part1 length] == 0)
        {
            [label setText:part2];
            *coordinate = CGPointMakeAndRound(point.x, coordinate->y + [label.font lineHeight]);
        }
        else
        {
            // Keep new line tag at the end for redrawing.
            [label setText:[NSString stringWithFormat:@"%@\n", part1]];
            
            SDLabel *nextLabel = [[SDLabel alloc] init];
            [nextLabel setFont:label.font];
            [nextLabel setText:part2];
            [nextLabel setEvent:label.event];
            [nextLabel setTextColor:label.textColor];
            [nextLabel setHighlightedTextColor:label.highlightedTextColor];
            [nextLabel addRelatedItem:label];
            [_items insertObject:nextLabel atIndex:[_items indexOfObject:label] + 1];
            [nextLabel release];
            
            return YES;
        }
    }
    
    return NO;
}

- (CGPoint)getEndpointForDrawingAtPoint:(CGPoint)point doDrawing:(BOOL)drawing
{
    CGPoint coordinate = point;
    CGPoint maxEndpoint = CGPointZero;
    
    for (NSInteger i = 0; i < [_items count]; i++)
    {
        SDLabel *label = [_items objectAtIndex:i];
        if (![label isKindOfClass:[SDLabel class]])
            continue;
        
        BOOL newLine = NO;
        
        // Split label, if it has new line characters included.
        NSArray *split = [label.text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        newLine = [self splitLabel:label byComponents:split coordinate:&coordinate point:point];
        
        if (self.hasWidthLimitation)
        {
            // Split label, if it's too long.
            NSString *parts = [self divideLabel:label forDrawingAt:CGSubstractTwoPoints(coordinate, point) lineBreakMode:UILineBreakModeWordWrap];
            NSArray *components = [parts componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            newLine = [self splitLabel:label byComponents:components coordinate:&coordinate point:point];
        }
        
        // If label size exceed maximum height, finish drawing immediately.
        if (self.hasHeightLimitation)
        {
            BOOL exceed = ([label sizeForPoint:coordinate].height + coordinate.y > _maxHeight);
            if (exceed)
                break;            
        }
                
        // If not drawing, just get size of this label, otherwise do drawing, too.
        CGSize size = (!drawing) ? [label sizeForPoint:coordinate] : [label drawAtPoint:coordinate];
        
        // Resize sentence control if needed.
        CGPoint endpoint = CGEndpointFromCGRect(CGRectMakeFromOriginAndSize(coordinate, size));
        if (endpoint.x > maxEndpoint.x)
            maxEndpoint = CGPointMake(endpoint.x, maxEndpoint.y);
        if (endpoint.y > maxEndpoint.y)
            maxEndpoint = CGPointMake(maxEndpoint.x, endpoint.y);
        
        // Set coordinate for next control.
        coordinate = (newLine)
        ? CGPointMakeAndRound(point.x, coordinate.y + [label.font lineHeight])
        : CGPointMakeAndRound(endpoint.x, coordinate.y);
    }
    
    return CGPointRound(CGSubstractTwoPoints(maxEndpoint, point));
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
