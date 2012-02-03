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

- (void)addLabelForText:(NSString *)text
{
    if ([text length] == 0)
        return;
    
    SDLabel *label = [[SDLabel alloc] init];
    [label setTextColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    
    [label setText:text];
    [_labels addObject:label];
    
    [label release];
}

- (void)createForElement:(BBElement *)element
{
    NSMutableString *temporary = [[NSMutableString alloc] init];
    
    NSInteger endTagIndex = -1;
    for (int i = 0; i < [element.text length]; i++)
    {
        NSString *character = [element.text substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"["])
        {
            NSString *text = [element.text substringWithRange:NSMakeRange(endTagIndex + 1, i - endTagIndex - 1)];
            [self addLabelForText:text];
            
            [temporary release];
            temporary = [[NSMutableString alloc] init];            
            
            _parsingTag = YES;
        }
        else if ([character isEqualToString:@"]"])
        {
            NSInteger index = [temporary integerValue];
            BBElement *subelement = [element.elements objectAtIndex:index];
            [self createForElement:subelement];
            
            [temporary release];
            temporary = [[NSMutableString alloc] init];  
            
            endTagIndex = i;
            _parsingTag = NO;
        }
        else
        {
            [temporary appendString:character];
        }
    }
    
    if ([temporary length] > 0)
        [self addLabelForText:temporary];
}

- (void)dealloc
{
    [_labels release];
    [super dealloc];
}

@end
