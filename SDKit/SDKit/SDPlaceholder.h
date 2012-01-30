//
//  BCView.h
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDControl;

@interface SDPlaceholder : NSObject {
    NSMutableArray *subcontrols;
    NSMutableArray *highlightedSubcontrols;
    NSMutableArray *siblingControls;
    
    UIView *parent;
}

@property (nonatomic, retain) UIView *parent;

- (id)initWithParent:(UIView *)parentView;

- (void)addSibling:(SDPlaceholder *)control;
- (void)addSubcontrol:(SDControl *)control;
- (void)removeSubcontrol:(SDControl *)control;

- (void)touchBeganAtLocation:(CGPoint)location;
- (void)touchEndedAtLocation:(CGPoint)location;
- (void)touchMovedAtLocation:(CGPoint)location;
- (void)touchCanceledAtLocation:(CGPoint)location;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
