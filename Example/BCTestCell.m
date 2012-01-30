//
//  BCTestCell.m
//  Style
//
//  Created by Miha Rataj on 30.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCTestCell.h"

@implementation BCTestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _sentence = [[SDSentence alloc] init];
        [_sentence setMaxWidth:265];
        
        _image = [[SDImageView alloc] initWithSize:CGSizeMake(40, 40)];
        [_image setImage:[UIImage imageNamed:@"woman.jpg"]];
        
        [_placeholder setItems:[NSArray arrayWithObjects:_image, _sentence, nil]];
        
        SDLabel *sender = [[SDLabel alloc] init];
        [sender setText:@"Anne Frank"];
        [sender setEvent:[SDEvent eventForTarget:self selector:@selector(showText:) andObject:sender.text]];
        [sender setFont:[UIFont boldSystemFontOfSize:15.0]];
        [sender setTextColor:[UIColor blueColor]];
        
        SDLabel *description = [[SDLabel alloc] init];
        [description setText:@"shared link"];
        [description setFont:[UIFont systemFontOfSize:15.0]];
        [description setTextColor:[UIColor grayColor]];
        
        SDLabel *link = [[SDLabel alloc] init];
        [link setText:@"http://www.youtube.com/watch?v=zBO0rrGHjC8&feature=g-all-u&context=G26a38e4FAAAAAAAADAA"];
        [link setEvent:[SDEvent eventForTarget:self selector:@selector(showText:) andObject:link.text]];
        [link setFont:[UIFont boldSystemFontOfSize:15.0]];
        [link setTextColor:[UIColor blueColor]];
        
        SDLabel *to = [[SDLabel alloc] init];
        [to setText:@"to person"];
        [to setFont:[UIFont systemFontOfSize:15.0]];
        [to setTextColor:[UIColor grayColor]];
        
        SDLabel *receiver = [[SDLabel alloc] init];
        [receiver setText:@"Johnny English"];
        [receiver setEvent:[SDEvent eventForTarget:self selector:@selector(showText:) andObject:receiver.text]];
        [receiver setFont:[UIFont boldSystemFontOfSize:15.0]];
        [receiver setTextColor:[UIColor blueColor]];
        
        SDLabel *ending = [[SDLabel alloc] init];
        [ending setText:@"."];
        [ending setFont:[UIFont systemFontOfSize:15.0]];
        [ending setTextColor:[UIColor grayColor]];
        
        [_sentence setItems:[NSArray arrayWithObjects:sender, description, link, to, receiver, ending, nil]];
        
        [sender release];
        [description release];
        [link release];
        [to release];
        [receiver release];
        [ending release];
    }
    return self;
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

- (void)dealloc
{
    [_sentence release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
