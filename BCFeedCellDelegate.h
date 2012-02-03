//
//  BCFeedCellDelegate.h
//  Example
//
//  Created by Miha Rataj on 3.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BCFeedCellDelegate <NSObject>
- (void)showUser:(id)params;
- (void)showDocument:(id)params;
- (void)showLink:(id)params;
@end
