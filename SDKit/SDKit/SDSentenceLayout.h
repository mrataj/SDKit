//
//  SDSentenceLayout.h
//  SDKit
//
//  Created by Miha Rataj on 3.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDLabel;
@class BBElement;

@interface SDSentenceLayout : NSObject {
    
}

- (SDLabel *)getLayoutForElement:(BBElement *)element;

@end