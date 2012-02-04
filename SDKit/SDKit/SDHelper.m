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

@end

@implementation NSMutableString (BCStyleHelper)

- (void)appendWord:(NSString *)word withSpace:(BOOL)space
{
    if (space)
        [self appendFormat:@"%@ ", word];
    else
        [self appendString:word];
}

@end

CGPoint CGEndpointFromCGRect(CGRect rect)
{
    return CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
}

CGPoint CGPointRound(CGPoint point)
{
    return CGPointMake(floor(point.x), floor(point.y));
}

CGPoint CGPointMakeAndRound(CGFloat x, CGFloat y)
{
    return CGPointRound(CGPointMake(x, y));
}

CGRect CGRectMakeFromOriginAndSize(CGPoint origin, CGSize size)
{
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

CGPoint CGSubstractTwoPoints(CGPoint point1, CGPoint point2)
{
    return CGPointMake(point1.x - point2.x, point1.y - point2.y);
}

CGPoint CGAggregateTwoPoints(CGPoint point1, CGPoint point2)
{
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}

CGSize CGSizeMakeFromPoint(CGPoint point)
{
    return CGSizeMake(point.x, point.y);
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