//
//  BCTableViewController.m
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCTableViewController.h"
#import "BCTestCell.h"

@implementation BCTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setTitle:@"Feed"];
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
    [self.tableView setRowHeight:200.0];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    BCTestCell *cell = (BCTestCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[BCTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    [cell.image setImage:[UIImage imageNamed:@"woman.jpg"]];
    
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
    
    [cell.sentence setItems:[NSArray arrayWithObjects:sender, description, link, to, receiver, ending, nil]];
    
    [sender release];
    [description release];
    [link release];
    [to release];
    [receiver release];
    [ending release];
    
    return cell;
}

@end
