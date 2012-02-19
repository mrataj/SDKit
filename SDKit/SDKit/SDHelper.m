//
//  SDHelper.m
//  Style
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDHelper.h"

@implementation NSString (BCStyleHelper)

- (BOOL)isURL
{
    return [self hasPrefix:@"http"] && [self rangeOfString:@"://"].location != NSNotFound;
}

- (NSString *)trim
{
    return [self stringByReplacingOccurrencesOfString:@" +" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

- (NSArray *)componentsSeparatedByString:(NSString *)separator includeSeparator:(BOOL)include
{
    if (!include)
        return [self componentsSeparatedByString:separator];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"%@+", separator]
                                                                           options:0
                                                                             error:nil];
    NSArray *matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if ([matches count] < 1)
        return [NSArray arrayWithObject:self];
    
    NSMutableArray *words = [NSMutableArray array];
    NSInteger previousIndex = 0;
    for (NSTextCheckingResult *match in matches)
    {
        NSRange range = [match range];
        
        NSString *word = [self substringWithRange:NSMakeRange(previousIndex, range.location - previousIndex)];
        if ([word length] > 0)
            [words addObject:word];
        
        previousIndex = range.location;
    }
    
    NSString *word = [self substringFromIndex:previousIndex];
    if ([word length] > 0)
        [words addObject:word];
    
    return words;
}

@end

CGPoint CGEndpointFromCGRect(CGRect rect)
{
    return CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
}

CGPoint CGPointRound(CGPoint point)
{
    return CGPointMake(ceilf(point.x), ceilf(point.y));
}

CGSize CGSizeRound(CGSize size)
{
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

void CGContextAddRoundedRect(CGContextRef c, CGRect rect, CGFloat radius)
{
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGContextMoveToPoint(c, minX + radius, minY);
    CGContextAddArcToPoint(c, maxX, minY, maxX, minY + radius, radius);
    CGContextAddArcToPoint(c, maxX, maxY, maxX - radius, maxY, radius);
    CGContextAddArcToPoint(c, minX, maxY, minX, maxY - radius, radius);
    CGContextAddArcToPoint(c, minX, minY, minX + radius, minY, radius);
}