//
//  BNRItemTableViewController.m
//  Homepwner
//
//  Created by Maxwell Zhou on 7/15/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemTableViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"
@interface BNRItemTableViewController ()

@property (nonatomic) IBOutlet UIView *headerView;

@end

@implementation BNRItemTableViewController

- (instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 0; i++)
        {
            [[BNRItemStore sharedStore] createItem];
        }
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"HomeDemo";
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}


- (void)   tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
   forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        // Also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    // Give detail view controller a pointer to the item object in row
    detailViewController.item = selectedItem;
    
    // Push it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove"; // or put something else
}

- (void)   tableView:(UITableView *)tableView
  moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
         toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}
- (NSInteger) tableView:(UITableView *) tableView
numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore]allItems]count];
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
    return self.init;
}

- (IBAction)addNewItem:(id)sender
{
 //   NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
