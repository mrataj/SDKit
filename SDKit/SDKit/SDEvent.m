//
//  SDEvent.m
//  Style
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDEvent.h"

@implementation SDEvent

@synthesize object=_object, selector=_selector, target=_target;

+ (SDEvent *)eventForTarget:(id)tar selector:(SEL)sel andObject:(id)obj
{
    SDEvent *event = [[SDEvent alloc] init];
    [event setTarget:tar];
    [event setSelector:sel];
    [event setObject:obj];
    return [event autorelease];
}

+ (SDEvent *)eventForTarget:(id)tar selector:(SEL)sel
{
    return [SDEvent eventForTarget:tar selector:sel andObject:nil];
}

- (void)performEvent
{
    if ([_target respondsToSelector:_selector])
        [_target performSelector:_selector withObject:_object];
}

- (void)dealloc
{
    _selector = nil;
    [_object release];
    [_target release];
    [super dealloc];
}

@end
