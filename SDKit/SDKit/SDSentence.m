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

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw
{
    CGFloat maxWidth = (self.hasWidthLimitation) ? self.maxWidth : 1000;
    CGFloat maxHeight = (self.hasHeightLimitation) ? self.hasHeightLimitation : 1000;
    
    if (draw)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        
        CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
        
        CGRect rect = CGRectMake(20.0, point.y, maxWidth, maxHeight);
        
        CGContextTranslateCTM(ctx, rect.origin.x, rect.origin.y);
        CGContextScaleCTM(ctx, 1.0f, -1.0f);
        CGContextTranslateCTM(ctx, rect.origin.x, - (rect.origin.y + rect.size.height));
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, rect);
        
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(self.attributedString));
        CTFrameRef frame = CTFramesetterCreateFrame( framesetter, CFRangeMake( 0, 0 ), path, NULL );
        
        CTFrameDraw(frame, ctx);
        
        CGPathRelease(path);
        CFRelease(frame);
        CFRelease(framesetter);
        
        CGContextRestoreGState(ctx); 
    }
    
    CGRect textRect = [self.attributedString boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                          context:nil];
    return textRect.size;
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
