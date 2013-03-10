//
//  BCFeedLayout.m
//  Example
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Marg, d.o.o. All rights reserved.
//

#import "BCFeedLayout.h"
#import "BBElement.h"

@implementation BCFeedLayout

- (UIFont *)getFont:(BBElement *)element
{
    if ([self isTagSupported:element.tag])
    {
        return [UIFont boldSystemFontOfSize:16.0];
    }
    else
    {
        return [UIFont systemFontOfSize:16.0];
    }
}

- (UIColor *)getTextColor:(BBElement *)element
{
    if ([self isTagSupported:element.tag])
    {
        return [UIColor colorWithRed:59/255.0 green:90/255.0 blue:155/255.0 alpha:1.0];
    }
    else
    {
        return [UIColor darkGrayColor];
    }
}

- (NSArray *)getSupportedTags
{
    return [NSArray arrayWithObjects:
            @"user",
            @"document",
            @"link",
            nil];
}

- (BOOL)isTagSupported:(NSString *)tag
{
    for (NSString *supportedTag in [self getSupportedTags])
        if ([tag isEqualToString:supportedTag])
            return YES;
    
    return NO;
}

@end
