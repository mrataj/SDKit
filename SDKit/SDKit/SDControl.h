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
}

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, assign) BOOL highlighted;

- (CGSize)drawAtPoint:(CGPoint)point;

@end
