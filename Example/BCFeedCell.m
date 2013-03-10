//
//  BCFeedCell.m
//  Example
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCFeedCell.h"
#import "BBSentence.h"

@implementation BCFeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _sentence = [[BBSentence alloc] init];
        [_sentence setOnTouchUp:[SDEvent eventForTarget:self selector:@selector(onTouchUp:)]]; // todo add instead of set
        
        _image = [[SDImageView alloc] initWithSize:CGSizeMake(40, 40)];
        
        [_placeholder setItems:[NSArray arrayWithObjects:_image, _sentence, nil]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [_image drawAtPoint:CGPointMake(5, 5)];
    
    [_sentence setMaxWidth:rect.size.width - 55];
    [_sentence drawAtPoint:CGPointMake(50, 5)];
}

- (void)onTouchUp:(SDSentenceTouchEventArgument *)eventArgument
{
    if ([self.delegate respondsToSelector:@selector(cell:onSentenceTouchUp:)])
        [self.delegate performSelector:@selector(cell:onSentenceTouchUp:) withObject:self withObject:eventArgument];
}

+ (CGFloat)heightForBbCode:(BBCodeString *)code andWidth:(CGFloat)width
{
    CGFloat height = 10.0;
    
    BBSentence *sentence = [[BBSentence alloc] init];
    [sentence setMaxWidth:width - 55];
    [sentence setBbCode:code];
    height += [sentence sizeForPoint:CGPointMake(50, 5)].height;
    
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
