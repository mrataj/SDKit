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
    
    SDControl *__weak _previousControl;
    SDControl *__weak _nextControl;
}

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, assign) UIEdgeInsets touchInset;
@property (nonatomic, weak) SDControl *previousControl;
@property (nonatomic, weak) SDControl *nextControl;

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw;
- (CGSize)drawAtPoint:(CGPoint)point;
- (CGSize)sizeForPoint:(CGPoint)point;
- (void)setHighlightEffect:(NSNumber *)highlight;

@end
