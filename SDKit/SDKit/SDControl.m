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

@synthesize frame=_frame, highlighted=_highlighted, touchInset=_touchInset;

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
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

#pragma mark - Touches

- (void)touchBeganAtLocation:(CGPoint)location
{
    [super touchBeganAtLocation:location];
    [self setHighlighted:YES];
    [_parent setNeedsDisplay];
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    [self setHighlighted:NO];
    [_parent setNeedsDisplay];
}

- (void)touchMovedAtLocation:(CGPoint)location
{
    [super touchMovedAtLocation:location];
    [self setHighlighted:NO];
    [_parent setNeedsDisplay];
}

- (void)touchCanceledAtLocation:(CGPoint)location
{
    [super touchCanceledAtLocation:location];
    [self setHighlighted:NO];
    [_parent setNeedsDisplay];
}

@end
