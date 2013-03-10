//
//  SDControl.m
//  SDKit
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDControl.h"
#import "SDPlaceholder.h"

@implementation SDControl

@synthesize frame=_frame, highlighted=_highlighted, touchInset=_touchInset, previousControl=_previousControl, nextControl=_nextControl;

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
    _previousControl = nil;
    _nextControl = nil;
}

#pragma mark - For override

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw
{
    @throw [NSException exceptionWithName:@"This has to be overriden." reason:@"This has to be overriden." userInfo:nil];
}

- (CGSize)drawAtPoint:(CGPoint)point
{
    CGSize size = [self sizeForDrawingAtPoint:point draw:YES];
    _frame = CGRectMake(point.x, point.y, ceilf(size.width), ceilf(size.height));
    return size;
}

- (CGSize)sizeForPoint:(CGPoint)point
{
    return [self sizeForDrawingAtPoint:point draw:NO];
}

#pragma mark - Properties

- (void)setHighlightEffect:(NSNumber *)highlight
{
    _highlighted = [highlight boolValue];
    
    if (_previousControl.highlighted != _highlighted)
        [_previousControl setHighlightEffect:highlight];
    
    if (_nextControl.highlighted != _highlighted)
        [_nextControl setHighlightEffect:highlight];
}

- (void)setPreviousControl:(SDControl *)previousControl
{
    _previousControl = previousControl;
    [_previousControl setNextControl:self];
}

#pragma mark - Touches

- (void)touchBeganAtLocation:(CGPoint)location
{
    [super touchBeganAtLocation:location];
    [self setHighlightEffect:[NSNumber numberWithBool:YES]];
    [_parent setNeedsDisplay];
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    [self performSelector:@selector(setHighlightEffect:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.15];
    [_parent performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.16];
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
    [_parent setNeedsDisplay];
}

@end
