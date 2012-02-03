//
//  BCSentenceLayout.m
//  Example
//
//  Created by Miha Rataj on 3.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCSentenceLayout.h"


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
                    [UIColor redColor], @"quote",
                    [UIColor grayColor], @"",
                    [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0], @"user",
                    [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0], @"document",
                    [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0], @"link",
                    nil];
    }
    
    return [__colors objectForKey:name];
}

+ (UIColor *)fontForTag:(NSString *)name
{
    if (__fonts == nil)
    {
        __fonts = [[NSDictionary alloc] initWithObjectsAndKeys:
                   [UIFont boldSystemFontOfSize:15.0], @"bold",
                   [UIFont systemFontOfSize:15.0], @"",
                   nil];
    }
    
    return [__colors objectForKey:name];
}

- (SDLabel *)getLayoutForElement:(BBElement *)element
{
    SDLabel *label = [[SDLabel alloc] init];
    [label setTextColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    return [label autorelease];
}

- (void)dealloc
{
    [super dealloc];
}

@end
