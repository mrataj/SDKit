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
        _mutable = [[NSMutableString alloc] init];
        
        BBCodeParser *parser = [[BBCodeParser alloc] initWithCode:code];
        [parser setDelegate:self];
        [parser parse];
        [parser release];
    }
    return self;
}

- (SDEvent *)eventForTag:(NSString *)name
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
    // Handle mutable hack first
    if ([_mutable length] > 0)
    {
        SDLabel *lbl = [[SDLabel alloc] init];
        [lbl setFont:[UIFont systemFontOfSize:15.0]];
        [lbl setText:_mutable];
        [lbl setTextColor:[UIColor grayColor]];
        [_items addObject:lbl];
        [lbl release];
    }
    
    [_mutable release];
    _mutable = nil;
    
    
    
    SDLabel *label = [[SDLabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    
    // Apply styles
    if (tag == @"quote")
        [label setTextColor:[UIColor grayColor]];
    else if (tag == @"bold")
        [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize]];
    
    // Apply event
    SDEvent *event = [self eventForTag:tag];
    if (event != nil)
    {
        [event setObject:attributes];
        [label setEvent:event];
        [label setTextColor:[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0]];
        [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize]];
    }
    
    [_items addObject:label];
    [label release];
}

- (void)parser:(BBCodeParser *)parser foundCharacters:(NSString *)string
{
    if (_mutable != nil)
        [_mutable appendString:string];
}

- (void)parser:(BBCodeParser *)parser didEndElement:(BBElement *)element
{
    SDLabel *label = [_items lastObject];
    [label setText:element.value];
    
    _mutable = [[NSMutableString alloc] init];
}

- (void)dealloc
{
    [_items release];
    [_mutable release];
    [super dealloc];
}

@end