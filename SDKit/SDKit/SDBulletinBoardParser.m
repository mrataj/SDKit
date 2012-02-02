//
//  SDBulletinBoardParser.m
//  SDKit
//
//  Created by Miha Rataj on 1.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDBulletinBoardParser.h"
#import "SDLabel.h"

static NSString *startTag = @"[";
static NSString *endTag = @"]";

@interface SDBulletinBoardParser (private)
- (void)didStartParsingElement:(NSString *)elementName;
- (void)didEndParsingElement:(NSString *)elementName elementValue:(NSString *)elementValue;
@end

@implementation SDBulletinBoardParser

- (NSArray *)parseText:(NSString *)bbCode
{
    [_items release];
    _items = [[NSMutableArray alloc] init];
    
    NSMutableString *currentElementName;
    NSMutableString *currentElementValue = [[NSMutableString alloc] init];
    BOOL parsingFinishTag = NO, parsingTextWithinTag = NO;
    for (int i = 0; i < [bbCode length]; i++)
    {
        NSString *character = [bbCode substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:startTag])
        {
            if (currentElementValue != nil && [currentElementValue length] > 0 && !parsingTextWithinTag)
            {
                [self didEndParsingElement:nil elementValue:currentElementValue];
            }
            
            currentElementName = [[NSMutableString alloc] init];
        }
        else if ([character isEqualToString:endTag])
        {
            if (parsingFinishTag)
            {
                [self didEndParsingElement:currentElementName elementValue:currentElementValue];
                
                [currentElementValue release];
                currentElementValue = [[NSMutableString alloc] init];
                
                parsingTextWithinTag = NO;
            }
            else
            {
                [self didStartParsingElement:currentElementName];
                parsingTextWithinTag = YES;
            }
            
            [currentElementName release];
            currentElementName = nil;
            parsingFinishTag = NO;
            
            currentElementValue = [[NSMutableString alloc] init];
        }
        else if ([character isEqualToString:@"/"])
        {
            if (currentElementName != nil && [currentElementName length] == 0)
                parsingFinishTag = YES;
        }
        else
        {
            if (currentElementName != nil)
                [currentElementName appendString:character];
            else if (currentElementValue != nil)
                [currentElementValue appendString:character];
        }
    }
    [currentElementValue release];
    
    return _items;
}

- (void)didStartParsingElement:(NSString *)elementName
{
    
}

- (void)didEndParsingElement:(NSString *)elementName elementValue:(NSString *)elementValue
{
    SDLabel *label = [[SDLabel alloc] init];
    [label setText:elementValue];
    if ([elementName isEqualToString:@"bold"] || [elementName isEqualToString:@"user"] || [elementName isEqualToString:@"document"] || [elementName isEqualToString:@"link"])
        [label setFont:[UIFont boldSystemFontOfSize:15.0]];
    else
        [label setFont:[UIFont systemFontOfSize:15.0]];
    if ([elementName isEqualToString:@"quote"])
        [label setTextColor:[UIColor grayColor]];
    else if ([elementName isEqualToString:@"user"] || [elementName isEqualToString:@"document"] || [elementName isEqualToString:@"link"])
        [label setTextColor:[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0]];
    else
        [label setTextColor:[UIColor blackColor]];
    [_items addObject:label];
    [label release];
}

- (void)dealloc
{
    [_items release];
    [super dealloc];
}

@end
