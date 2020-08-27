//
//  ContactListTableViewController.m
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "Contact+CoreDataProperties.h"
#import "ContactListTableViewController.h"

@interface ContactListTableViewController ()

typedef NSArray<Contact *> ContactArray;
@property (strong, nonatomic) ContactArray *contacts;

@end

@implementation ContactListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactTableViewCell"];

    NSUInteger row = indexPath.row;
    
    if (self.contacts.count > row) {
        Contact *contact = self.contacts[row];
        [cell setupCellWithContact:contact];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

@end
