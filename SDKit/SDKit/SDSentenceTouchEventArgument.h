//
//  SDSentenceTouchEventArgument.h
//  SDKit
//
//  Created by Miha Rataj on 10. 03. 13.
//  Copyright (c) 2013 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDSentenceTouchEventArgument : NSObject

@property (nonatomic, assign) CGPoint touchLocation;
@property (nonatomic, assign) NSInteger characterIndex;

@end
