//
//  SDButton.m
//  SDKit
//
//  Created by Miha Rataj on 4.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDButton.h"
#import "SDHelper.h"

@implementation SDButton

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (CGPoint)getEndpointForDrawingAtPoint:(CGPoint)point doDrawing:(BOOL)drawing
{
    return CGPointZero;
}

- (CGSize)drawAtPoint:(CGPoint)point
{
    CGPoint endpoint = [self getEndpointForDrawingAtPoint:point doDrawing:YES];    
    return [self createdAtPoint:point withSize:CGSizeMakeFromPoint(CGSubstractTwoPoints(endpoint, point))];
}

- (CGSize)sizeForPoint:(CGPoint)point
{
    CGPoint endpoint = [self getEndpointForDrawingAtPoint:point doDrawing:NO];
    return CGSizeMakeFromPoint(CGSubstractTwoPoints(endpoint, point));
}

- (void)dealloc
{
    [super dealloc];
}
@end
