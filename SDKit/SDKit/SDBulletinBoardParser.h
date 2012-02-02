//
//  SDBulletinBoardParser.h
//  SDKit
//
//  Created by Miha Rataj on 1.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDBulletinBoardParser : NSObject {
    NSMutableArray *_items;
}

- (NSArray *)parseText:(NSString *)bbCode;

@end
