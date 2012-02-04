//
//  SDHelper.h
//  Style
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BCStyleHelper)

@property (nonatomic, readonly, getter=isURL) BOOL isURL;

@end

@interface NSMutableString (BCStyleHelper)

- (void)appendWord:(NSString *)word withSpace:(BOOL)space;

@end

CGPoint CGEndpointFromCGRect(CGRect rect);

CGPoint CGPointRound(CGPoint point);

CGPoint CGPointMakeAndRound(CGFloat x, CGFloat y);

CGRect CGRectMakeFromOriginAndSize(CGPoint origin, CGSize size);

CGPoint CGSubstractTwoPoints(CGPoint point1, CGPoint point2);

CGPoint CGAggregateTwoPoints(CGPoint point1, CGPoint point2);

CGSize CGSizeMakeFromPoint(CGPoint point);

static void CGContextAddRoundedRect(CGContextRef c, CGRect rect, CGFloat radius);