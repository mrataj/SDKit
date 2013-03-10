//
//  SDPlaceholder.m
//  SDKit
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDPlaceholder.h"
#import "SDControl.h"
#import "SDHelper.h"

@implementation SDPlaceholder

@synthesize parent=_parent, items=_items;

- (id)init
{
    self = [super init];
    if (self)
    {
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithParent:(UIView *)parent
{
    self = [self init];
    if (self)
    {
        _parent = parent;
    }
    return self;
}

- (void)dealloc
{
    _parent = nil;
}

#pragma mark - Properties

- (void)setItems:(NSArray *)items
{
    if (items == _items)
        return;
    
    if (![items isKindOfClass:[NSMutableArray class]])
        _items  = [[NSMutableArray alloc] initWithArray:items];
    else
        _items = (NSMutableArray *)items;
    
    if (_parent != nil)
        for (SDControl *item in _items)
            [item setParent:_parent];
    
    [_parent setNeedsDisplay];
}

#pragma mark - Touches

- (NSArray *)getItemsAtLocation:(CGPoint)location
{    
    NSMutableArray *respondingControls = [NSMutableArray array];
    for (SDControl *item in _items)
    {
        CGRect touchFrame = UIEdgeInsetsInsetRect(item.frame, item.touchInset);        
        if (CGRectContainsPoint(touchFrame, location))
            [respondingControls addObject:item];
    }
    
    return respondingControls;
}

- (void)touchBeganAtLocation:(CGPoint)location
{
    NSArray *items = [self getItemsAtLocation:location];
    for (SDControl *item in items)
    {
        [item touchBeganAtLocation:location];       
    }
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    NSArray *items = [self getItemsAtLocation:location];
    for (SDControl *control in items)
        [control touchEndedAtLocation:location];
}

- (void)touchMovedAtLocation:(CGPoint)location
{
    NSArray *items = [self getItemsAtLocation:location];
    for (SDControl *control in items)
        [control touchMovedAtLocation:location];
}

- (void)touchCanceledAtLocation:(CGPoint)location
{
    NSArray *items = [self getItemsAtLocation:location];
    for (SDControl *control in items)
        [control touchCanceledAtLocation:location];
}

#pragma mark - UIView

- (CGPoint)getTouchLocation:(NSSet *)touches
{    
    UITouch *touch = [touches anyObject];
    return [touch locationInView:_parent];    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 1)
        return;
    
    CGPoint location = [self getTouchLocation:touches];
    [self touchBeganAtLocation:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 1)
        return;
    
    CGPoint location = [self getTouchLocation:touches];
    [self touchMovedAtLocation:location];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 1)
        return;
    
    CGPoint location = [self getTouchLocation:touches];
    [self touchEndedAtLocation:location];
}

@end
