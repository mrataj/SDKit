//
//  SDControl.m
//  Style
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDControl.h"
#import "SDPlaceholder.h"

@implementation SDControl

@synthesize frame=_frame, highlighted=_highlighted;

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (CGSize)drawAtPoint:(CGPoint)point
{
    return CGSizeZero;
}

- (CGSize)sizeForPoint:(CGPoint)point
{
    return CGSizeZero;
}

- (CGSize)createdAtPoint:(CGPoint)point withSize:(CGSize)size
{
    _frame = CGRectMake(point.x, point.y, size.width, size.height);
    return size;
}

- (void)setHighlightEffect:(NSNumber *)highlight
{
    _highlighted = [highlight boolValue];
    for (SDControl *sibling in siblingControls)
        [sibling setHighlighted:[highlight boolValue]];
    
    [parent setNeedsDisplay];
}

- (void)touchBeganAtLocation:(CGPoint)location
{
    [super touchBeganAtLocation:location];
    [self setHighlightEffect:[NSNumber numberWithBool:YES]];  
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    [self performSelector:@selector(setHighlightEffect:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.15];
}

- (void)touchMovedAtLocation:(CGPoint)location
{
    [super touchMovedAtLocation:location];
    [self touchCanceledAtLocation:location];
}

- (void)touchCanceledAtLocation:(CGPoint)location
{
    [super touchCanceledAtLocation:location];
    [self setHighlightEffect:[NSNumber numberWithBool:NO]];
}

@end
