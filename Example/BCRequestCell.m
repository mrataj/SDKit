//
//  BCRequestCell.m
//  Example
//
//  Created by Miha Rataj on 5.2.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCRequestCell.h"

@implementation BCRequestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _button = [[SDButton alloc] init];
        [_button setSize:CGSizeMake(70, 26)];
        [_button setText:@"Push"];
        [_button setEvent:[SDEvent eventForTarget:self selector:@selector(showText)]];
        
        [_placeholder setItems:[NSArray arrayWithObject:_button]];
    }
    return self;
}

- (void)showText
{
    NSLog(@"Button clicked.");
}

- (void)drawRect:(CGRect)rect
{
    [_button drawAtPoint:CGPointMake(4, 15)];
}

- (void)dealloc
{
    [_button release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
