//
//  SDSentenceBuilder.h
//  SDKit
//
//  Created by Miha Rataj on 2.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDSentenceBuilderDelegate.h"
#import "BBCodeParser.h"

@interface SDSentenceBuilder : NSObject <BBCodeParserDelegate> {
    NSMutableArray *_labels;
    NSString *_code;
    
    BOOL _parsingTag;
    
    id<SDSentenceBuilderDelegate> _delegate;
}

@property (nonatomic, readonly) NSArray *labels;
@property (nonatomic, assign) id<SDSentenceBuilderDelegate> delegate;

- (id)initWithCode:(NSString *)code;
- (void)build;

@end
