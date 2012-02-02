//
//  SDSentenceBuilder.m
//  SDKit
//
//  Created by Miha Rataj on 2.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDSentenceBuilder.h"
#import "SDEvent.h"
#import "SDLabel.h"

static NSMutableDictionary *events;

@implementation SDSentenceBuilder

@synthesize items=_items;

- (id)initWithCode:(NSString *)code
{
    self = [super init];
    if (self)
    {
        _items = [[NSMutableArray alloc] init];
        
        BBCodeParser *parser = [[BBCodeParser alloc] initWithCode:code];
        [parser setDelegate:self];
        [parser parse];
        [parser release];
    }
    return self;
}

- (SDEvent *)eventForAttributeName:(NSString *)name value:(NSString *)value
{
    if (events == nil)
    {
        events = [[NSMutableDictionary alloc] init];
        [events setObject:[SDEvent eventForTarget:self selector:@selector(showUser:)] forKey:@"user"];
        [events setObject:[SDEvent eventForTarget:self selector:@selector(showDocument:)] forKey:@"document"];
        [events setObject:[SDEvent eventForTarget:self selector:@selector(showLink:)] forKey:@"link"];
    }
    
    return [events objectForKey:name];
}

- (void)parser:(BBCodeParser *)parser didStartElementTag:(NSString *)tag attributes:(NSDictionary *)attributes
{
    SDLabel *label = [[SDLabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    
    // Apply styles
    if (tag == @"quote")
        [label setTextColor:[UIColor grayColor]];
    else if (tag == @"bold")
        [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize]];
    
    // Apply event
    for (NSString *key in attributes.allKeys)
    {
        NSString *value = [attributes objectForKey:key];
        SDEvent *event = [self eventForAttributeName:key value:value];
        if (event != nil)
        {
            [label setEvent:event];
            [label setTextColor:[UIColor redColor]];
            [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize]];
        }
    }
    
    [_items addObject:label];
    [label release];
}

- (void)parser:(BBCodeParser *)parser didEndElement:(BBElement *)element
{
    SDLabel *label = [_items lastObject];
    [label setText:element.value];
}

- (void)dealloc
{
    [_items release];
    [super dealloc];
}

@end
