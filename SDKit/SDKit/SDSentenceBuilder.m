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

@interface SDSentenceBuilder (private)
- (void)createForElement:(BBElement *)element;
@end


@implementation SDSentenceBuilder

@synthesize labels=_labels;

- (id)initWithCode:(NSString *)code
{
    self = [super init];
    if (self)
    {
        _labels = [[NSMutableArray alloc] init];
        
        BBCodeParser *parser = [[BBCodeParser alloc] initWithCode:code];
        [parser setDelegate:self];
        [parser parse];
        [self createForElement:parser.element];
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

- (void)createForElement:(BBElement *)element
{
    SDLabel *label = [[SDLabel alloc] init];
    [label setTextColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    
    [label setText:element.text];
    [_labels addObject:label];
    
    [label release];
    
    for (BBElement *subelement in element.elements)
    {
    }
}

- (void)dealloc
{
    [_labels release];
    [super dealloc];
}

@end
