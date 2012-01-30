//
//  SDImage.h
//  Style
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDControl.h"

@class SDEvent;

@interface SDImageView : SDControl {
    CGSize _size;
    SDEvent *_event;
    UIImage *_image;
}

@property (nonatomic, assign) CGSize size;
@property (nonatomic, retain) SDEvent *event;
@property (nonatomic, retain) UIImage *image;

- (id)initWithSize:(CGSize)size;

@end
