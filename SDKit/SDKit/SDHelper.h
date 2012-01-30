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
CGPoint CGPointMakeAndRound(CGFloat x, CGFloat y);