//
//  BCTableViewController.h
//  Example
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCFeedCellDelegate.h"

@class BCFeedLayout;

@interface BCFeedViewController : UITableViewController <BCFeedCellDelegate> {
    NSArray *_model;
    BCFeedLayout *_layout;
}

@end
