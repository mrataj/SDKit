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

@synthesize parent;

- (id)init
{
    self = [super init];
    if (self)
    {
        subcontrols = [[NSMutableArray alloc] init];
        highlightedSubcontrols = [[NSMutableArray alloc] init];
        siblingControls = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithParent:(UIView *)parentView
{
    self = [self init];
    if (self)
    {
        parent = [parentView retain];
    }
    return self;
}

- (void)dealloc
{
    [subcontrols release];
    [highlightedSubcontrols release];
    [siblingControls release];
    [parent release];
    [super dealloc];
}

#pragma mark - Subcontrols and siblings

- (void)addSibling:(SDPlaceholder *)control
{
    // If control already exist in list, do nothing.
    for (id exiting in siblingControls)
        if (exiting == control)
            return;
    
    // If one control is sibling to another, the other control is also sibling of this control.
    [siblingControls addObject:control];
    [control addSibling:self];
    
    // Also, make all other siblings controls sibling of that control and self.
    for (SDControl *sibling in siblingControls)
        [sibling addSibling:control];
}

- (void)addSubcontrol:(SDControl *)control
{
    // If control already exist in list, do nothing.
    for (id exiting in subcontrols)
        if (exiting == control)
            return;
    
    [control setParent:parent];
    [subcontrols addObject:control];
}

- (void)removeSubcontrol:(SDControl *)control
{
    [subcontrols removeObject:control];
}

#pragma mark - Touches

- (NSArray *)getControlsAtLocation:(CGPoint)location
{    
    NSMutableArray *respondingControls = [NSMutableArray array];
    for (SDControl *control in subcontrols)
        if (CGRectContainsPoint(control.frame, location))
            [respondingControls addObject:control];
    
    return respondingControls;
}

- (void)touchBeganAtLocation:(CGPoint)location
{
    NSArray *touchedControls = [self getControlsAtLocation:location];
    for (SDControl *control in touchedControls)
    {
        [control touchBeganAtLocation:location];
        [highlightedSubcontrols addObject:control];        
    }
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    for (SDControl *control in highlightedSubcontrols)
        [control touchEndedAtLocation:location];
    
    [highlightedSubcontrols removeAllObjects];
}

- (void)touchMovedAtLocation:(CGPoint)location
{
    NSArray *touchedControls = [self getControlsAtLocation:location];
    for (SDControl *control in touchedControls)
        [control touchMovedAtLocation:location];
}

- (void)touchCanceledAtLocation:(CGPoint)location
{
    for (SDControl *control in highlightedSubcontrols)
        [control touchCanceledAtLocation:location];
    
    [highlightedSubcontrols removeAllObjects];
}

#pragma mark - UIView

- (CGPoint)getTouchLocation:(NSSet *)touches
{    
    UITouch *touch = [touches anyObject];
    return [touch locationInView:parent];    
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
