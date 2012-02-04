//
//  BCTableViewController.h
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCFeedCellDelegate.h"

@interface BCFeedViewController : UITableViewController <BCFeedCellDelegate> {
    NSArray *dataSource;
}

@end
