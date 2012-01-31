//
//  BCView.m
//  Style
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
        _highlightedItems = [[NSMutableArray alloc] init];
        _relatedItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithParent:(UIView *)parent
{
    self = [self init];
    if (self)
    {
        _parent = [parent retain];
    }
    return self;
}

- (void)dealloc
{
    [_items release];
    [_highlightedItems release];
    [_relatedItems release];
    [_parent release];
    [super dealloc];
}

#pragma mark - Subcontrols and siblings

- (void)addRelatedItem:(SDPlaceholder *)item
{
    // If control already exist in list, do nothing.
    for (id exiting in _relatedItems)
        if (exiting == item)
            return;
    
    // If one control is related to another, the other control is also related to this control.
    [_relatedItems addObject:item];
    [item addRelatedItem:self];
    
    // Also, make all other related controls related to that control.
    for (SDControl *relatedItem in _relatedItems)
        [relatedItem addRelatedItem:item];
}

- (void)setItems:(NSMutableArray *)items
{
    if (items == _items)
        return;
    
    [_items release];
    if (![items isKindOfClass:[NSMutableArray class]])
        _items  = [[NSMutableArray alloc] initWithArray:items];
    else
        _items = [items retain];
    
    for (SDControl *item in _items)
        [item setParent:_parent];
}

#pragma mark - Touches

- (NSArray *)getItemsAtLocation:(CGPoint)location
{    
    NSMutableArray *respondingControls = [NSMutableArray array];
    for (SDControl *item in _items)
        if (CGRectContainsPoint(item.frame, location))
            [respondingControls addObject:item];
    
    return respondingControls;
}

- (void)touchBeganAtLocation:(CGPoint)location
{
    NSArray *items = [self getItemsAtLocation:location];
    for (SDControl *item in items)
    {
        [item touchBeganAtLocation:location];
        [_highlightedItems addObject:item];        
    }
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    for (SDControl *control in _highlightedItems)
        [control touchEndedAtLocation:location];
    
    [_highlightedItems removeAllObjects];
}

- (void)touchMovedAtLocation:(CGPoint)location
{
    NSArray *items = [self getItemsAtLocation:location];
    for (SDControl *control in items)
        [control touchMovedAtLocation:location];
}

- (void)touchCanceledAtLocation:(CGPoint)location
{
    for (SDControl *control in _highlightedItems)
        [control touchCanceledAtLocation:location];
    
    [_highlightedItems removeAllObjects];
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
