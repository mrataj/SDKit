//
//  BCTestCell.h
//  Style
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDKit.h"

@interface BCTestCell : SDTableViewCell {
    SDSentence *_sentence;
    SDImageView *_image;    
}

@property (nonatomic, retain) SDSentence *sentence;
@property (nonatomic, retain) SDImageView *image;

+ (CGFloat)heightForSentence:(NSArray *)items;

@end
