//
//  SDButton.m
//  SDKit
//
//  Created by Miha Rataj on 4.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDButton.h"
#import "SDHelper.h"
#import "SDEvent.h"

@implementation SDButton

@synthesize size=_size, event=_event, font=_font, textColor=_textColor, backgroundColor=_backgroundColor;

- (id)init
{
    self = [super init];
    if (self)
    {
        _size = CGSizeMake(50, 24);
        _event = nil;
        _font = [[UIFont boldSystemFontOfSize:14.0] retain];
        _textColor = [[UIColor whiteColor] retain];
        _backgroundColor = [[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0] retain];
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

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    [_event performEvent];
}

- (void)dealloc
{
    [_event release];
    [_font release];
    [_textColor release];
    [_backgroundColor release];
    [super dealloc];
}
@end
