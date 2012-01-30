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

@interface SDSentence (private)
- (BOOL)canInsertSpace:(NSInteger)elementIndex afterLabel:(SDLabel *)label;
@end

@interface SDControl (protected)
- (CGSize)createdAtPoint:(CGPoint)point withSize:(CGSize)size;
@end

@implementation SDSentence

@synthesize maxWidth=_maxWidth, maxHeight=_maxHeight;

- (BOOL)doCharacterWrap:(NSString *)word label:(SDLabel *)label coordinate:(CGPoint *)coordinate atPoint:(CGPoint)point
{
    for (NSInteger j = 1; j < [word length] + 1; j++)
    {
        NSString *trimmed = [word substringToIndex:j];
        
        [label setText:trimmed];
        CGSize size = [label sizeForPoint:*coordinate];
        
        BOOL exceed = (coordinate->x + size.width > point.x + _maxWidth);
        if (exceed)
        {
            NSString *currentWord = [word substringToIndex:j - 1];
            NSString *nextWord = [word substringFromIndex:j - 1];                            
            
            // If current word is empty string, don't create new label, just go to new line.
            if ([currentWord length] < 1)
            {
                *coordinate = CGPointMakeAndRound(point.x, coordinate->y + [label.font lineHeight]);
                [label setText:nextWord];
                return NO;
            }
            // Otherwise, fill as much text as it goes to this line, and create new label (for new line).
            else
            {
                [label setText:currentWord];
            }
            
            // TODO: This has to be done with NSCopying
            SDLabel *nextLabel = [[SDLabel alloc] init];
            [nextLabel setFont:label.font];
            [nextLabel setText:nextWord];
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

- (BOOL)doWordWrap:(NSString *)word words:(NSArray *)words label:(SDLabel *)label coordinate:(CGPoint *)coordinate atPoint:(CGPoint)point
{
    // Text which will fill current line.
    NSMutableString *currentWord = [NSMutableString string];
    for (NSInteger j = 0; j < [words indexOfObject:word]; j++)
        [currentWord appendWord:[words objectAtIndex:j] withSpace:j + 1 != [words indexOfObject:word]];
    
    // The rest of the text (for new line)
    NSMutableString *nextWord = [NSMutableString string];
    for (NSInteger j = [words indexOfObject:word]; j < [words count]; j++)
        [nextWord appendWord:[words objectAtIndex:j] withSpace:j + 1 != [words count]];
    
    // Add as much text as it goes to current line.
    if ([currentWord length] < 1)
    {
        *coordinate = CGPointMakeAndRound(point.x, coordinate->y + [label.font lineHeight]);
        [label setText:nextWord];
        return NO;
    }
    else
    {
        [label setText:currentWord];
    }
    
    // Create new label with the rest of the text.
    // TODO: This has to be done with NSCopying
    SDLabel *nextLabel = [[SDLabel alloc] init];
    [nextLabel setFont:label.font];
    [nextLabel setText:nextWord];
    [nextLabel setEvent:label.event];
    [nextLabel setTextColor:label.textColor];
    [nextLabel setHighlightedTextColor:label.highlightedTextColor];
    [nextLabel addRelatedItem:label];
    [_items insertObject:nextLabel atIndex:[_items indexOfObject:label] + 1];
    [nextLabel release];
    
    return YES;
}

- (BOOL)splitWords:(SDLabel *)label point:(CGPoint)point coordinate:(CGPoint *)coordinate
{
    // Splits words in two parts (in most cases finish current line and create new line).
    // Returns coordinate of current drawn word and flag, if next word has to be created in new line.
    
    NSArray *words = [label.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSMutableString *mutable = [NSMutableString string];
    for (NSString *word in words)
    {
        [mutable appendWord:word withSpace:[words indexOfObject:word] + 1 != [words count]];
        [label setText:mutable];
        CGSize size = [label sizeForPoint:*coordinate];
        
        BOOL exceed = (coordinate->x + size.width > point.x + _maxWidth);
        if (exceed)
        {
            // If this word is longer than line, do character wrap.
            if (size.width > _maxWidth)
                return [self doCharacterWrap:word label:label coordinate:&(*coordinate) atPoint:point];
            else
                return [self doWordWrap:word words:words label:label coordinate:&(*coordinate) atPoint:point];
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
        
        // Check if label size will exceed maximum width.
        // In that case, split text and draw next word in new line.
        BOOL newLine = NO;
        if (self.hasWidthLimitation)
        {
            CGSize size = [label sizeForPoint:coordinate];
            BOOL exceed = (coordinate.x + size.width > point.x + _maxWidth);
            if (exceed)
                newLine = [self splitWords:label point:point coordinate:&coordinate];
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
        else if (endpoint.y > maxEndpoint.y)
            maxEndpoint = CGPointMake(maxEndpoint.x, endpoint.y);
        
        // Set coordinate for next control.
        coordinate = (newLine)
        ? CGPointMakeAndRound(point.x, coordinate.y + [label.font lineHeight])
        : CGPointMakeAndRound(endpoint.x, coordinate.y);
    }
    
    return CGPointRound(CGSubstractTwoPoints(maxEndpoint, point));
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
    [super dealloc];
}

@end
