//
//  BCSentenceLayout.m
//  Example
//
//  Created by Miha Rataj on 3.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCSentenceLayout.h"
#import "BBElement.h"


static NSDictionary *__events;
static NSDictionary *__colors;
static NSDictionary *__fonts;


@implementation BCSentenceLayout

+ (SDEvent *)eventForTag:(NSString *)name
{
    if (__events == nil)
    {
        __events = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [SDEvent eventForTarget:self selector:@selector(showUser:)], @"user",
                    [SDEvent eventForTarget:self selector:@selector(showDocument:)], @"document",
                    [SDEvent eventForTarget:self selector:@selector(showLink:)], @"link",
                    nil];
    }
    
    return [__events objectForKey:name];
}

+ (UIColor *)colorForTag:(NSString *)name
{
    if (__colors == nil)
    {
        __colors = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [UIColor grayColor], @"",
                    [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0], @"user",
                    [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0], @"document",
                    [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0], @"link",
                    nil];
    }
    
    return [__colors objectForKey:name];
}

+ (UIColor *)getTextColorRecursively:(BBElement *)element
{
    UIColor *color = [self colorForTag:element.tag];
    if (color == nil && element.parent != nil)
        return [self getTextColorRecursively:element.parent];
    
    return color;
}

+ (UIFont *)fontForTag:(NSString *)name
{
    if (__fonts == nil)
    {
        __fonts = [[NSDictionary alloc] initWithObjectsAndKeys:
                   [UIFont boldSystemFontOfSize:15.0], @"user",
                   [UIFont boldSystemFontOfSize:15.0], @"document",
                   [UIFont boldSystemFontOfSize:15.0], @"link",
                   [UIFont boldSystemFontOfSize:15.0], @"bold",
                   [UIFont italicSystemFontOfSize:15.0], @"quote",
                   [UIFont systemFontOfSize:15.0], @"",
                   nil];
    }
    
    return [__fonts objectForKey:name];
}

+ (UIFont *)getFontRecursively:(BBElement *)element
{
    UIFont *font = [self fontForTag:element.tag];
    if (font == nil && element.parent != nil)
        return [self getFontRecursively:element.parent];
    
    return font;
}

- (SDLabel *)getLayoutForElement:(BBElement *)element
{
    SDLabel *label = [[SDLabel alloc] init];
    [label setTextColor:[BCSentenceLayout getTextColorRecursively:element]];
    [label setFont:[BCSentenceLayout getFontRecursively:element]];
    return [label autorelease];
}

- (void)dealloc
{
    [super dealloc];
}

@end
