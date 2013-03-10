//
//  SDSentence.m
//  SDKit
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDSentence.h"
#import "SDHelper.h"
#import "SDEvent.h"
#import "SDSentenceTouchEventArgument.h"

@implementation SDSentence

const CGFloat _defaultMaxWidth = 1000;
const CGFloat _defaultMaxHeight = 1000;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw
{
    CGFloat maxWidth = (self.hasWidthLimitation) ? self.maxWidth : _defaultMaxWidth;
    CGFloat maxHeight = (self.hasHeightLimitation) ? self.hasHeightLimitation : _defaultMaxHeight;
    
    // Get rectangle for string
    CGRect rect = [self.attributedString boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                      context:nil];
    rect.origin = point;
    
    if (draw)
    {
        // Get graphics context
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // Save state
        CGContextSaveGState(ctx);
        
        // Draw background if needed
        if (self.backgroundColor != [UIColor clearColor])
        {
            CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
            CGContextFillRect(ctx, rect);
        }
        
        CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
        
        // Flip coordinate system
        CGContextTranslateCTM(ctx, 1.0f, rect.origin.y);
        CGContextScaleCTM(ctx, 1.0f, -1.0f);
        CGContextTranslateCTM(ctx, 1.0f, - (rect.origin.y + rect.size.height));
        
        // Set path
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, rect);
        
        // Create frame with attributed string
        CFAttributedStringRef stringToDraw = (__bridge CFAttributedStringRef)self.attributedString;
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(stringToDraw);
        
        // Make sure that we release frame before assigning it
        if (_ctFrame != nil)
        {
            CFRelease(_ctFrame);
            _ctFrame = nil;
        }
        
        _ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
        
        // Draw frame with attributed string
        CTFrameDraw(_ctFrame, ctx);
        
        // Release created items
        CGPathRelease(path);
        CFRelease(framesetter);
        
        // Restore state
        CGContextRestoreGState(ctx); 
    }
    
    return rect.size;
}

- (BOOL)hasHeightLimitation
{
    return _maxHeight > 0;
}

- (BOOL)hasWidthLimitation
{
    return _maxWidth > 0;
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    
    CGPoint relativeLocation = CGPointMake(location.x - _frame.origin.x, location.y - _frame.origin.y);
    
    // Set argument
    SDSentenceTouchEventArgument *argument = [[SDSentenceTouchEventArgument alloc] init];
    [argument setTouchLocation:relativeLocation];
    [argument setCharacterIndex:[self getCharacterIndexForTouchLocation:relativeLocation]];
    [_event setObject:argument];
    
    // Perform event
    [_event performEvent];
}

- (NSInteger)getCharacterIndexForTouchLocation:(CGPoint)touchLocation
{
    CGPoint reverseTouchLocation = CGPointMake(touchLocation.x, self.frame.size.height - touchLocation.y);
    
    CFArrayRef lines = CTFrameGetLines(_ctFrame);
    
    CGPoint* lineOrigins = malloc(sizeof(CGPoint) * CFArrayGetCount(lines));
    
    CTFrameGetLineOrigins(_ctFrame, CFRangeMake(0,0), lineOrigins);
    
    NSInteger index = -1;
    for (CFIndex i = 0; i < CFArrayGetCount(lines); i++)
    {
        CTLineRef currentLine = CFArrayGetValueAtIndex(lines, i);
        
        CGPoint origin = lineOrigins[i];
        if (reverseTouchLocation.y > origin.y)
        {
            index = CTLineGetStringIndexForPosition(currentLine, reverseTouchLocation);
            break;
        }
    }
    
    free(lineOrigins);
    
    return index;
}

- (void)dealloc
{
    if (_ctFrame != nil)
    {
        CFRelease(_ctFrame);        
    }
}

@end
