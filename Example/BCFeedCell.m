//
//  BCTestCell.m
//  Style
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCFeedCell.h"

@interface BCFeedCell (private)
+ (SDLabel *)sentenceElementlayout;
@end

static NSMutableDictionary *__events;

@implementation BCFeedCell

@synthesize sentence=_sentence, image=_image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _sentence = [[SDSentence alloc] initWithLayout:[BCFeedCell sentenceElementlayout]];
        [_sentence setMaxWidth:265];
        
        _image = [[SDImageView alloc] initWithSize:CGSizeMake(40, 40)];
        
        [_placeholder setItems:[NSArray arrayWithObjects:_image, _sentence, nil]];
    }
    return self;
}

+ (SDEvent *)eventForTag:(NSString *)name
{
    if (__events == nil)
    {
        __events = [[NSMutableDictionary alloc] init];
        [__events setObject:[SDEvent eventForTarget:self selector:@selector(showUser:)] forKey:@"user"];
        [__events setObject:[SDEvent eventForTarget:self selector:@selector(showDocument:)] forKey:@"document"];
        [__events setObject:[SDEvent eventForTarget:self selector:@selector(showLink:)] forKey:@"link"];
    }
    
    return [__events objectForKey:name];
}

+ (SDLabel *)sentenceElementlayout
{
    SDLabel *label = [[SDLabel alloc] init];
    [label setTextColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:15.0]];
    return [label autorelease];
}

- (void)showText:(NSString *)text
{
    NSLog(@"%@", text);
}

- (void)drawRect:(CGRect)rect
{
    [_image drawAtPoint:CGPointMake(5, 5)];    
    [_sentence drawAtPoint:CGPointMake(50, 5)];
}

+ (CGFloat)heightForCode:(NSString *)code
{
    CGFloat height = 10.0;
    
    SDLabel *layout = [BCFeedCell sentenceElementlayout];
    
    SDSentence *sentence = [[SDSentence alloc] initWithLayout:layout];
    [sentence setMaxWidth:265];
    [sentence setBBCode:code];
    height += [sentence sizeForPoint:CGPointMake(50, 5)].height;
    [sentence release];
    
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
