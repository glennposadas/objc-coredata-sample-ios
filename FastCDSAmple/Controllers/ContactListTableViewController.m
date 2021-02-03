//
//  ContactListTableViewController.m
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

#import "AppDelegate.h"
#import "AddContactViewController.h"
#import "ContactTableViewCell.h"
#import "Contact+CoreDataProperties.h"
#import "Details+CoreDataProperties.h"
#import "ContactListTableViewController.h"
@import CoreData;

@interface ContactListTableViewController () <UISearchBarDelegate>

typedef NSArray<Contact *> ContactArray;
@property (strong, nonatomic) ContactArray *contacts;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSManagedObjectContext *bgContext;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation ContactListTableViewController

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self fetchData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        if(searchText) {
            NSMutableArray *subPredicates = [[NSMutableArray alloc] init];
            [subPredicates addObject:[NSPredicate predicateWithFormat: @"name CONTAINS[cd] %@", searchText]];
            [subPredicates addObject:[NSPredicate predicateWithFormat: @"details.email CONTAINS[cd] %@", searchText]];
            [subPredicates addObject:[NSPredicate predicateWithFormat: @"details.phone CONTAINS[cd] %@", searchText]];
            
            NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
            
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
            request.predicate = predicate;
            
            __block NSArray *array;
            [self->_bgContext performBlockAndWait:^{
                NSError *error;
                array = [self->_bgContext executeFetchRequest:request error:&error];
            }];
            
            self.contacts = array;
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                [self.tableView reloadData];
            });
            
        }
    });
}

- (void)fetchData {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    
    __block NSArray *array;
    [_bgContext performBlockAndWait:^{
        NSError *error;
        array = [_bgContext executeFetchRequest:request error:&error];
    }];
    
    self.contacts = array;
    dispatch_async(dispatch_get_main_queue(), ^
                   {
        [self.tableView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    self.bgContext = self.appDelegate.persistentContainer.newBackgroundContext;
    self.searchBar.showsCancelButton = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    AddContactViewController *addContactVC = (AddContactViewController *)segue.destinationViewController;
    [addContactVC setContactBlock:^(NSData * imageData, NSString *name, NSString *phone, NSString *email) {
        [self createAndSaveData:imageData withName:name withPhone:phone andEmail:email];
    }];
}

- (void)createAndSaveData:(NSData *)imageData withName:(NSString *)name withPhone:(NSString *)phone andEmail:(NSString *)email {
    NSEntityDescription *contactEntity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:_bgContext];
    
    Contact *newContact = (Contact *)[[NSManagedObject alloc] initWithEntity:contactEntity insertIntoManagedObjectContext:_bgContext];
    [newContact setValue:imageData forKey:@"photo"];
    [newContact setValue:name forKey:@"name"];
    
    NSEntityDescription *detailsEntity = [NSEntityDescription entityForName:@"Details" inManagedObjectContext:_bgContext];
    Details *details = (Details *)[[NSManagedObject alloc] initWithEntity:detailsEntity insertIntoManagedObjectContext:_bgContext];
    [details setValue:phone forKey:@"phone"];
    [details setValue:email forKey:@"email"];
    
    [newContact setValue:details forKey:@"details"];
    
    NSError *error = nil;
    [self.bgContext save:&error];
    [self fetchData];
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
