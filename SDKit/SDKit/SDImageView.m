//
//  SDImage.m
//  Style
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDImageView.h"
#import "SDEvent.h"

@implementation SDImageView

@synthesize size=_size, event=_event, image=_image;

- (id)initWithSize:(CGSize)size
{
    self = [super init];
    if (self)
    {
        _size = size;
    }
    return self;
}

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw
{
    if (draw)
        [_image drawInRect:CGRectMake(point.x, point.y, _size.width, _size.height)];
    
    return _size;    
}

- (void)touchEndedAtLocation:(CGPoint)location
{
    [super touchEndedAtLocation:location];
    [_event performEvent];
}


@end
