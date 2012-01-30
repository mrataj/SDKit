//
//  SDEvent.h
//  Style
//
//  Created by Miha Rataj on 29.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDEvent : NSObject {
    id _target;
    SEL _selector;
    id _object;
}

@property (nonatomic, retain) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, retain) id object;

+ (SDEvent *)eventForTarget:(id)tar selector:(SEL)sel andObject:(id)obj;
+ (SDEvent *)eventForTarget:(id)tar selector:(SEL)sel;

- (void)performEvent;

@end
