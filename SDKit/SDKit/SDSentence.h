//
//  SDSentence.h
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "SDControl.h"

@interface SDSentence : SDControl

@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong) NSAttributedString *attributedString;
@property (nonatomic, readonly) BOOL hasHeightLimitation;
@property (nonatomic, readonly) BOOL hasWidthLimitation;
@property (nonatomic, strong) UIColor *backgroundColor;

@end
