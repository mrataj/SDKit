//
//  BCTestCell.m
//  Style
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCFeedCell.h"

@implementation BCFeedCell

@synthesize sentence=_sentence, image=_image, delegate=_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _sentence = [[SDSentence alloc] init];
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

+ (CGFloat)heightForAttributedString:(NSAttributedString *)string andWidth:(CGFloat)width
{
    CGFloat height = 10.0;
    
    SDSentence *sentence = [[SDSentence alloc] init];
    [sentence setMaxWidth:width - 55];
    [sentence setAttributedString:string];
    height += [sentence sizeForPoint:CGPointMake(50, 5)].height;
    
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
