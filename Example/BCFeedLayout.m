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

- (UIFont *)getFont:(BBElement *)element selected:(BOOL)selected
{
    if ([self isTagClickable:element.tag])
    {
        return [UIFont boldSystemFontOfSize:16.0];
    }
    else
    {
        return [UIFont systemFontOfSize:16.0];
    }
}

- (UIColor *)getTextColor:(BBElement *)element selected:(BOOL)selected
{
    if ([self isTagClickable:element.tag])
    {
        return (selected) ? [UIColor blackColor] : [UIColor colorWithRed:59/255.0 green:90/255.0 blue:155/255.0 alpha:1.0];
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

- (BOOL)isTagClickable:(NSString *)tag
{
    for (NSString *supportedTag in [self getSupportedTags])
        if ([tag isEqualToString:supportedTag])
            return YES;
    
    return NO;
}

@end
