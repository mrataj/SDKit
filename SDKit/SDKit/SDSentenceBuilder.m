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
#import "SDSentenceLayout.h"

@interface SDSentenceBuilder (private)
- (void)createForElement:(BBElement *)element;
@end


@implementation SDSentenceBuilder

@synthesize labels=_labels, layout=_layout;

- (id)initWithCode:(NSString *)code
{
    self = [super init];
    if (self)
    {
        _labels = [[NSMutableArray alloc] init];
        _code = [code copy];
    }
    return self;
}

- (void)build
{
    BBCodeParser *parser = [[BBCodeParser alloc] initWithCode:_code];
    [parser parse];
    [self createForElement:parser.element];
    [parser release];
}

- (void)createLabel:(NSString *)text forElement:(BBElement *)element
{
    if ([text length] == 0)
        return;
    
    SDLabel *layout = [_layout getLayoutForElement:element];
    
    SDLabel *label = [[SDLabel alloc] init];
    [label setTextColor:layout.textColor];
    [label setFont:layout.font];
    [label setEvent:layout.event];
    [label setText:text];
    [_labels addObject:label];
    [label release];
}

- (void)createForElement:(BBElement *)element
{
    NSMutableString *temporary = [NSMutableString string];
    
    NSInteger endTagIndex = -1;
    for (int i = 0; i < [element.text length]; i++)
    {
        NSString *character = [element.text substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"["])
        {
            NSString *text = [element.text substringWithRange:NSMakeRange(endTagIndex + 1, i - endTagIndex - 1)];
            [self createLabel:text forElement:element];
            
            temporary = [NSMutableString string];            
            
            _parsingTag = YES;
        }
        else if ([character isEqualToString:@"]"])
        {
            NSInteger index = [temporary integerValue];
            BBElement *subelement = [element.elements objectAtIndex:index];
            [self createForElement:subelement];
            
            temporary = [NSMutableString string];  
            
            endTagIndex = i;
            _parsingTag = NO;
        }
        else
        {
            [temporary appendString:character];
        }
    }
    
    if ([temporary length] > 0)
        [self createLabel:temporary forElement:element];
}

- (void)dealloc
{
    [_layout release];
    [_code release];
    [_labels release];
    [super dealloc];
}

@end
