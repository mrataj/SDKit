//
//  SDSentenceLayout.m
//  SDKit
//
//  Created by Miha Rataj on 3.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDSentenceLayout.h"
#import "SDLabel.h"
#import "BBElement.h"

@implementation SDSentenceLayout

@synthesize eventResponder=_eventResponder;

- (SDLabel *)getLayoutForElement:(BBElement *)element
{
    SDLabel *label = [[SDLabel alloc] init];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:12.0]];
    return label;
}

- (NSArray *)getTags
{
    @throw [NSException exceptionWithName:@"This method should be overrided." reason:@"You should override getTags method!" userInfo:nil];
}

- (void)dealloc
{
    _eventResponder = nil;
}

@end
