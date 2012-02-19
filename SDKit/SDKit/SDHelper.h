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

- (NSString *)trim;
- (NSArray *)componentsSeparatedByString:(NSString *)separator includeSeparator:(BOOL)include;

@end

CGPoint CGEndpointFromCGRect(CGRect rect);
CGPoint CGPointRound(CGPoint point);
CGSize CGSizeRound(CGSize size);
void CGContextAddRoundedRect(CGContextRef c, CGRect rect, CGFloat radius);