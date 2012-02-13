//
//  SDControl.h
//  Style
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDPlaceholder.h"

@interface SDControl : SDPlaceholder {
    CGRect _frame;
    BOOL _highlighted;
    UIEdgeInsets _touchInset;
    
    SDControl *_previousControl;
    SDControl *_nextControl;
}

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, assign) UIEdgeInsets touchInset;
@property (nonatomic, assign) SDControl *previousControl;
@property (nonatomic, assign) SDControl *nextControl;

- (CGSize)drawAtPoint:(CGPoint)point;
- (CGSize)sizeForPoint:(CGPoint)point;
- (CGSize)createdAtPoint:(CGPoint)point withSize:(CGSize)size;
- (void)setHighlightEffect:(NSNumber *)highlight;

@end
