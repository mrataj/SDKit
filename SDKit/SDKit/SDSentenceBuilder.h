//
//  SDSentenceBuilder.h
//  SDKit
//
//  Created by Miha Rataj on 2.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDSentenceLayout;

@interface SDSentenceBuilder : NSObject {
    NSMutableArray *_labels;
    NSString *_code;
    
    BOOL _parsingTag;
    
    SDSentenceLayout *_layout;
}

@property (nonatomic, readonly) NSArray *labels;
@property (nonatomic, retain) SDSentenceLayout *layout;

- (id)initWithCode:(NSString *)code;
- (void)build;

@end
