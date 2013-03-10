//
//  BCTableViewController.m
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCFeedViewController.h"
#import "BCFeedCell.h"
#import "BBCodeString.h"
#import "SDKit.h"
#import "BBElement.h"
#import "BCFeedLayout.h"
#import "BBSentence.h"

@implementation BCFeedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setTitle:@"News Feed"];
        
        UIBarButtonItem *create = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
        [self.navigationItem setRightBarButtonItem:create];
        
        _layout = [[BCFeedLayout alloc] init];
        
        NSString *text0 = @"Person [user id=\"2\"]James Newille[/user] said:\nI created this text yesterday morning.";
        BBCodeString *item0 = [[BBCodeString alloc] initWithBBCode:text0 andLayoutProvider:_layout];
        
        NSString *text1 = @"[user id=\"42\"]Kate Cameron[/user] meet person [user id=\"12\"]Guy Buckland[/user] 3 hours ago in [link]London, UK[/link].";
        BBCodeString *item1 = [[BBCodeString alloc] initWithBBCode:text1 andLayoutProvider:_layout];
        
        NSString *text2 = @"[user id=\"42\"]Kate Cameron[/user] created document [document id=\"23241\"]Example.doc[/document] and sent it to person [user id=\"22\"]Larry Brin[/user].";
        BBCodeString *item2 = [[BBCodeString alloc] initWithBBCode:text2 andLayoutProvider:_layout];
        
        NSString *text3 = @"[user id=\"42\"]Kate Cameron[/user] has writen a hundred miles long exam about supermassive black holes, saved it to file [document id=\"23089\"]Seminar paper.pdf[/document] and finally sent it to her professor of physics [user id=\"78\"]dr. Gregory Watson[/user].";
        BBCodeString *item3 = [[BBCodeString alloc] initWithBBCode:text3 andLayoutProvider:_layout];
        
        NSString *text4 = @"1. line\n2. line\n3. line\n\nThis is just an example to see how sentence control handle multiline text.";
        BBCodeString *item4 = [[BBCodeString alloc] initWithBBCode:text4 andLayoutProvider:_layout];
        
        NSString *text5 = @"This line is a text to see how sentence control can handle multiline space between lines.\n\n\n\nThere should be visible 3 empty lines.";
        BBCodeString *item5 = [[BBCodeString alloc] initWithBBCode:text5 andLayoutProvider:_layout];
        
        NSString *text6 = @"\nThere should be one empty line on top and two empty lines at bottom.\n\n";
        BBCodeString *item6 = [[BBCodeString alloc] initWithBBCode:text6 andLayoutProvider:_layout];
        
        NSString *text7 = @"{0} {~} {}";
        BBCodeString *item7 = [[BBCodeString alloc] initWithBBCode:text7 andLayoutProvider:_layout];
        
        _model = [[NSArray alloc] initWithObjects:item0, item1, item2, item3, item4, item5, item6, item7, nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_model count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBCodeString *code = [_model objectAtIndex:indexPath.row];
    return [BCFeedCell heightForBbCode:code andWidth:self.view.bounds.size.width];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    BCFeedCell *cell = (BCFeedCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[BCFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setDelegate:self];
    }
    
    [cell.image setImage:[UIImage imageNamed:@"woman.jpg"]];
    
    BBCodeString *code = [_model objectAtIndex:indexPath.row];
    [cell.sentence setBbCode:code];
    
    return cell;
}

#pragma mark - Events

- (void)cell:(BCFeedCell *)cell onSentenceTouchUp:(SDSentenceTouchEventArgument *)eventArgument
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    BBCodeString *code = [_model objectAtIndex:indexPath.row];
    BBElement *element = [code getElementByIndex:eventArgument.characterIndex];
    
    NSLog(@"%@", element.text);
}

@end
