//
//  BCTestCell.m
//  Style
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCFeedCell.h"
#import "BCSentenceLayout.h"

@implementation BCFeedCell

@synthesize sentence=_sentence, image=_image, delegate=_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _sentence = [[SDSentence alloc] init];
        [_sentence setMaxWidth:265];
        
        _image = [[SDImageView alloc] initWithSize:CGSizeMake(40, 40)];
        
        [_placeholder setItems:[NSArray arrayWithObjects:_image, _sentence, nil]];
    }
    return self;
}

- (void)setDelegate:(id)delegate
{
    _delegate = delegate;
    
    BCSentenceLayout *layout = [[BCSentenceLayout alloc] init];
    [layout setEventResponder:_delegate];
    [_sentence setLayout:layout];
    [layout release];
}

- (void)drawRect:(CGRect)rect
{
    [_image drawAtPoint:CGPointMake(5, 5)];    
    [_sentence drawAtPoint:CGPointMake(50, 5)];
}

+ (CGFloat)heightForCode:(NSString *)code
{
    CGFloat height = 10.0;
    
    BCSentenceLayout *layout = [[BCSentenceLayout alloc] init];
    SDSentence *sentence = [[SDSentence alloc] initWithLayout:layout];
    [sentence setMaxWidth:265];
    [sentence setBBCode:code];
    height += [sentence sizeForPoint:CGPointMake(50, 5)].height;
    [sentence release];
    [layout release];
    
    return height;
}

- (void)dealloc
{
    [_image release];
    [_sentence release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
