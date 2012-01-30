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

CGPoint CGPointMakeAndRound(CGFloat x, CGFloat y)
{
    return CGPointMake(floor(x), floor(y));
}