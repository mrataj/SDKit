//
//  BBSentence.m
//  Example
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Marg, d.o.o. All rights reserved.
//

#import "BBSentence.h"

@implementation BBSentence

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setOnTouchIn:[SDEvent eventForTarget:self selector:@selector(onTouchIn:)]];
        [self setOnTouchEnd:[SDEvent eventForTarget:self selector:@selector(onTouchEnd:)]];
    }
    return self;
}

- (void)setBbCode:(BBCodeString *)bbCode
{
    _bbCode = bbCode;
    
    [self setAttributedString:bbCode.attributedString];
}

- (void)onTouchIn:(SDSentenceTouchEventArgument *)eventArgument
{
    BBElement *selectedElement = [self.bbCode getElementByIndex:eventArgument.characterIndex];
    [_bbCode setSelectedElement:selectedElement];
}

- (void)onTouchEnd:(SDSentenceTouchEventArgument *)eventArgument
{
    [_bbCode setSelectedElement:nil];
}

@end
