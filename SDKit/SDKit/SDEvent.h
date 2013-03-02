//
//  SDEvent.h
//  Style
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDEvent : NSObject {
    id __weak _target;
    SEL _selector;
    id _object;
}

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) id object;

+ (SDEvent *)eventForTarget:(id)tar selector:(SEL)sel andObject:(id)obj;
+ (SDEvent *)eventForTarget:(id)tar selector:(SEL)sel;

- (void)performEvent;

@end
