//
//  SDMutableArray.m
//  SDKit
//
//  Created by Miha Rataj on 6.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDMutableArray.h"

@implementation SDMutableArray

- (void)addObject:(id)anObject
{
    NSValue *value = [NSValue valueWithNonretainedObject:anObject];
    [super addObject:value];
}

- (void)removeObject:(id)anObject
{
    for (NSValue *val in self)
    {
        id obj = [val nonretainedObjectValue];
        if (obj == anObject)
            [super removeObject:val];
    }
}

- (id)objectAtIndex:(NSUInteger)index
{
    NSValue *value = [super objectAtIndex:index];
    return [value nonretainedObjectValue];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id [])buffer count:(NSUInteger)len
{
    return [super countByEnumeratingWithState:state objects:buffer count:len];
}

@end
