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
    BBCodeParser *parser = [[BBCodeParser alloc] initWithTags:[_layout getTags]];
    [parser setCode:_code];
    [parser parse];
    [self createForElement:parser.element];
}

- (void)createLabel:(NSString *)text forElement:(BBElement *)element
{
    if ([text length] == 0)
        return;
    
    SDLabel *layout = [_layout getLayoutForElement:element];
    
    // TODO: Do this with NSCopying
    SDLabel *label = [[SDLabel alloc] init];
    [label setTextColor:layout.textColor];
    [label setFont:layout.font];
    [label setEvent:layout.event];
    [label setTouchInset:layout.touchInset];
    [label setText:text];
    [_labels addObject:label];
}

- (void)createForElement:(BBElement *)element
{    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[BBCodeParser tagRegexPattern] options:0 error:nil];
    NSArray *matches = [regex matchesInString:element.format options:0 range:NSMakeRange(0, [element.format length])];
    if ([matches count] < 1)
    {
        [self createLabel:element.text forElement:element];
        return;
    }
    
    NSInteger previousIndex = 0;
    for (NSTextCheckingResult *match in matches)
    {
        NSRange range = [match range];
        
        NSString *word = [element.format substringWithRange:NSMakeRange(previousIndex, range.location - previousIndex)];        
        [self createLabel:word forElement:element];
        
        NSString *tag = [element.format substringWithRange:range];
        
        NSRegularExpression *tagIndexRegex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+"
                                                                              options:0
                                                                                error:nil];
        
        NSTextCheckingResult *tagIndexResult = [[tagIndexRegex matchesInString:tag options:0 range:NSMakeRange(0, tag.length)] objectAtIndex:0];
        NSInteger index = [[tag substringWithRange:tagIndexResult.range] integerValue];
        
        BBElement *subelement = [element.elements objectAtIndex:index];
        [self createForElement:subelement];
        
        previousIndex = range.location + range.length;
    }
    
    NSString *word = [element.format substringFromIndex:previousIndex];
    if ([word length] > 0)
        [self createLabel:word forElement:element];
}


@end
