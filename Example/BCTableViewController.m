//
//  BCTableViewController.m
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCTableViewController.h"
#import "BCFeedCell.h"
#import "SDKit.h"

@implementation BCTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setTitle:@"News Feed"];
        
        UIBarButtonItem *create = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
        [self.navigationItem setRightBarButtonItem:create];
        [create release];
        
        NSString *item0 = @"[user]Kate Cameron[/user] shared link [link]http://www.youtube.com[/link] to person [user]Johnny English[/user].";
        NSString *item1 = @"[user]Kate Cameron[/user] meet person [user]Guy Buckland[/user] 3 hours ago in [link]London, UK.[/link].";
        NSString *item2 = @"[user]Kate Cameron[/user] created document [document]Example.doc[/document] and sent it to person [user]Larry Brin[/user].";
        NSString *item3 = @"[user]Kate Cameron[/user] has writen a hundred miles long exam about supermassive black holes, saved it to file [document]Seminar paper.pdf[/document] and finally sent it to her professor of physics [user]dr. Gregory Watson[/user].";
        
        dataSource = [[NSArray alloc] initWithObjects:item0, item1, item2, item3, nil];
    }
    return self;
}

- (void)dealloc
{
    [dataSource release];
    [super dealloc];
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
    return [dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *code = [dataSource objectAtIndex:indexPath.row];
    return [BCFeedCell heightForCode:code];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    BCFeedCell *cell = (BCFeedCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[BCFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    [cell.image setImage:[UIImage imageNamed:@"woman.jpg"]];
    
    NSString *code = [dataSource objectAtIndex:indexPath.row];
    [cell.sentence setBBCode:code];
    
    return cell;
}

@end
