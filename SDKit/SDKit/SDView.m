//
//  SDView.m
//  SDKit
//
//  Created by Miha Rataj on 2/13/12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDView.h"
#import "SDPlaceholder.h"

@implementation SDView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _placeholder = [[SDPlaceholder alloc] initWithParent:self];
    }
    return self;
}

- (void)dealloc
{
    [_placeholder release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_placeholder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [_placeholder touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [_placeholder touchesEnded:touches withEvent:event];
}

@end
