//
//  SDPlaceholder.h
//  SDKit
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDControl;

@interface SDPlaceholder : NSObject {
@protected
    NSMutableArray *_items;
    UIView *__weak _parent;
}

@property (nonatomic, weak) UIView *parent;
@property (nonatomic, strong) NSArray *items;

- (id)initWithParent:(UIView *)parent;

- (void)touchBeganAtLocation:(CGPoint)location;
- (void)touchEndedAtLocation:(CGPoint)location;
- (void)touchMovedAtLocation:(CGPoint)location;
- (void)touchCanceledAtLocation:(CGPoint)location;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
