//
//  SDControl.h
//  SDKit
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDPlaceholder.h"

@interface SDControl : SDPlaceholder {
    CGRect _frame;
    BOOL _highlighted;
    UIEdgeInsets _touchInset;
}

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, assign) UIEdgeInsets touchInset;

- (CGSize)sizeForDrawingAtPoint:(CGPoint)point draw:(BOOL)draw;
- (CGSize)drawAtPoint:(CGPoint)point;
- (CGSize)sizeForPoint:(CGPoint)point;

@end
