//
//  BCTableViewController.m
//  Style
//
//  Created by Miha Rataj on 28.1.12.
//  Copyright (c) 2012 Marg, d.o.o. All rights reserved.
//

#import "BCFeedViewController.h"
#import "BCFeedCell.h"
#import "SDKit.h"

@implementation BCFeedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self setTitle:@"News Feed"];
        
        UIBarButtonItem *create = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
        [self.navigationItem setRightBarButtonItem:create];
        [create release];
        
        NSString *item0 = @"\nPerson\n\n\nJames Newille created\nthis text.\n\n";
        
        /*
        NSString *item1 = @"[user id=\"42\"]Kate Cameron[/user] meet person [user id=\"12\"]Guy Buckland[/user] 3 hours ago in [link]London, UK[/link].";
        NSString *item2 = @"[user id=\"42\"]Kate Cameron[/user] created document [document id=\"23241\"]Example.doc[/document] and sent it to person [user id=\"22\"]Larry Brin[/user].";
        NSString *item3 = @"[user id=\"42\"]Kate Cameron[/user] has\nwriten\na\nhundred miles\nlong exam about supermassive black holes, saved it to file [document id=\"23089\"]Seminar paper.pdf[/document] and finally sent it to her professor of physics [user id=\"78\"]dr. Gregory Watson[/user].";
         */
        
        dataSource = [[NSArray alloc] initWithObjects:item0, /* item1, item2, item3, */ nil];
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

#pragma mark - Feed cell delegate methods

- (void)showParameters:(NSArray *)params
{
    for (BBAttribute *attribute in params)
    {
        NSLog(@"Key: %@, Value: %@", attribute.name, attribute.value);
    }
}

- (void)showUser:(id)params
{
    [self showParameters:params];
}

- (void)showDocument:(id)params
{
    [self showParameters:params];
}

- (void)showLink:(id)params
{
    [self showParameters:params];
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
        [cell setDelegate:self];
    }
    
    [cell.image setImage:[UIImage imageNamed:@"woman.jpg"]];
    
    NSString *code = [dataSource objectAtIndex:indexPath.row];
    [cell.sentence setBBCode:code];
    
    return cell;
}

@end
