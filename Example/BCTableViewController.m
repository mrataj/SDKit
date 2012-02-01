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
        [self setTitle:@"News Feed"];
        
        UIBarButtonItem *create = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
        [self.navigationItem setRightBarButtonItem:create];
        [create release];
        
        NSArray *item0 = [NSArray arrayWithObjects:@"Kate Cameron",
                          @"shared link",
                          @"http://www.youtube.com",
                          @"to person",
                          @"Johnny English",
                          @".", nil];
        
        NSArray *item1 = [NSArray arrayWithObjects:@"Kate Cameron",
                          @"meet person",
                          @"Guy Buckland",
                          @"3 hours ago in",
                          @"London",
                          @".", nil];
        
        NSArray *item2 = [NSArray arrayWithObjects:@"Kate Cameron",
                          @"created document",
                          @"Example.doc",
                          @"and sent it to person",
                          @"Larry Brin",
                          @".", nil];
        
        NSArray *item3 = [NSArray arrayWithObjects:@"Kate Cameron",
                          @"has writen a hundred miles long exam about supermassive black holes, saved it to file",
                          @"Seminar paper.pdf",
                          @"and finally sent it to her professor of physics",
                          @"dr. Gregory Watson",
                          @".", nil];
        
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

+ (NSMutableArray *)getSentenceItemsFromRow:(NSArray *)dataRow
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    SDLabel *sender = [[SDLabel alloc] init];
    [sender setText:[dataRow objectAtIndex:0]];
    [sender setEvent:[SDEvent eventForTarget:self selector:@selector(showText:) andObject:sender.text]];
    [sender setFont:[UIFont boldSystemFontOfSize:15.0]];
    [sender setTextColor:[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0]];
    [items addObject:sender];
    [sender release];
    
    SDLabel *description = [[SDLabel alloc] init];
    [description setText:[dataRow objectAtIndex:1]];
    [description setFont:[UIFont systemFontOfSize:15.0]];
    [description setTextColor:[UIColor grayColor]];
    [items addObject:description];
    [description release];
    
    SDLabel *link = [[SDLabel alloc] init];
    [link setText:[dataRow objectAtIndex:2]];
    [link setEvent:[SDEvent eventForTarget:self selector:@selector(showText:) andObject:link.text]];
    [link setFont:[UIFont boldSystemFontOfSize:15.0]];
    [link setTextColor:[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0]];
    [items addObject:link];
    [link release];
    
    SDLabel *to = [[SDLabel alloc] init];
    [to setText:[dataRow objectAtIndex:3]];
    [to setFont:[UIFont systemFontOfSize:15.0]];
    [to setTextColor:[UIColor grayColor]];
    [items addObject:to];
    [to release];
    
    SDLabel *receiver = [[SDLabel alloc] init];
    [receiver setText:[dataRow objectAtIndex:4]];
    [receiver setEvent:[SDEvent eventForTarget:self selector:@selector(showText:) andObject:receiver.text]];
    [receiver setFont:[UIFont boldSystemFontOfSize:15.0]];
    [receiver setTextColor:[UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0]];
    [items addObject:receiver];
    [receiver release];
    
    SDLabel *ending = [[SDLabel alloc] init];
    [ending setText:[dataRow objectAtIndex:5]];
    [ending setFont:[UIFont systemFontOfSize:15.0]];
    [ending setTextColor:[UIColor grayColor]];
    [items addObject:ending];
    [ending release];
    
    return [items autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dataRow = [dataSource objectAtIndex:indexPath.row];
    NSMutableArray *items = [BCTableViewController getSentenceItemsFromRow:dataRow];
    return [BCTestCell heightForSentence:items];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    BCTestCell *cell = (BCTestCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[BCTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    NSArray *dataRow = [dataSource objectAtIndex:indexPath.row];
    
    [cell.image setImage:[UIImage imageNamed:@"woman.jpg"]];
    
    NSMutableArray *items = [BCTableViewController getSentenceItemsFromRow:dataRow];
    [cell.sentence setItems:items];    
    
    return cell;
}

@end
