//
//  SDSentenceBuilder.h
//  SDKit
//
//  Created by Miha Rataj on 2.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCodeParser.h"

@interface SDSentenceBuilder : NSObject <BBCodeParserDelegate> {
    NSMutableArray *_items;
}

@property (nonatomic, readonly) NSArray *items;

- (id)initWithCode:(NSString *)code;

@end
