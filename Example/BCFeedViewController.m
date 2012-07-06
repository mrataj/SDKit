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
        
        NSString *item0 = @"Hack za https s server trust\n- (id)initWithAddress:(NSString *)anAddress\n\n{\n\nif((self = [self init])) {\n\nself.address = [NSURL URLWithString:anAddress];\n\nNSDictionary *serverTrust = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0], kValidateResult, nil];\n[self setAuthenticationProperties:[NSDictionary dictionaryWithObject:serverTrust forKey:NSURLAuthenticationMethodServerTrust]];\n\n}\n\n\nreturn self;\n\n}V ExternalProvider.svc.m file";
        NSString *item1 = @"[user id=\"42\"]Kate Cameron[/user] meet person [user id=\"12\"]Guy Buckland[/user] 3 hours ago in [link]London, UK[/link].";
        NSString *item2 = @"[user id=\"42\"]Kate Cameron[/user] created document [document id=\"23241\"]Example.doc[/document] and sent it to person [user id=\"22\"]Larry Brin[/user].";
        NSString *item3 = @"[user id=\"42\"]Kate Cameron[/user] has writen a hundred miles long exam about supermassive black holes, saved it to file [document id=\"23089\"]Seminar paper.pdf[/document] and finally sent it to her professor of physics [user id=\"78\"]dr. Gregory Watson[/user].";
        NSString *item4 = @"1. line\n2. line\n3. line\n\nThis is just an example to see how sentence control handle multiline text.";
        NSString *item5 = @"This line is a text to see how sentence control can handle multiline space between lines.\n\n\n\nThere should be visible 3 empty lines.";
        NSString *item6 = @"\nThere should be one empty line on top on one empty line on bottom.\n\n";
        
        dataSource = [[NSArray alloc] initWithObjects:item0, item1, item2, item3, item4, item5, item6, nil];
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
    return [BCFeedCell heightForCode:code andWidth:self.view.bounds.size.width];
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

#pragma mark - Orientation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.tableView reloadData];
}

@end
