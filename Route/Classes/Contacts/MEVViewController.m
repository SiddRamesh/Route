//
//  MEVViewController.m
//  MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 04/29/2016.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVViewController.h"
#import "MEVHorizontalContactsExample1.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface MEVViewController ()

//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MEVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Contacts";

 //   [self.tableView setDelegate:self];
 //   [self.tableView setDataSource:self];
    
    
 //   [self.tableView setBackgroundColor:[UIColor whiteColor]];
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
//    [self.tableView setEstimatedRowHeight:100];
//    [self.tableView setRowHeight:UITableViewAutomaticDimension];
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setBackgroundColor:[UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1]];

    MEVHorizontalContactsExample1 *horizontalContactsView = [MEVHorizontalContactsExample1 new];
    [cell addSubview:horizontalContactsView];
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContactsView" : horizontalContactsView}]];
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContactsView" : horizontalContactsView}]];
    
    return cell;
}


@end
