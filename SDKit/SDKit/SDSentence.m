//
//  BCSentence.m
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDSentence.h"
#import "SDHelper.h"
#import <CoreText/CoreText.h>

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
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(self.attributedString));
        CTFrameRef frame = CTFramesetterCreateFrame( framesetter, CFRangeMake( 0, 0 ), path, NULL );
        
        // Draw frame with attributed string
        CTFrameDraw(frame, ctx);
        
        // Release created items
        CGPathRelease(path);
        CFRelease(frame);
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

@end
