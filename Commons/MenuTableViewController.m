//
//  MenuTableViewController.m
//  Commons
//
//  Created by Jan Hennings on 1/27/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "MenuTableViewController.h"
#import "CLCommonsMenuFetcher.h"
#import "SettingsTableViewController.h"
#import "MenuTableViewCell.h"
#import "DetailsTableViewController.h"

@interface MenuTableViewController () <UIActionSheetDelegate>
@property (nonatomic) NSMutableArray *backupMenus;
@property (nonatomic) NSArray *activeMenus;
@property (nonatomic) NSMutableArray *mealTagFilter;
@property (assign) BOOL didLaunch;
@end

@implementation MenuTableViewController




- (NSArray *)activeMenus {
    if (!_activeMenus) {
        _activeMenus = [NSArray new];
    }
    return _activeMenus;
}

- (NSMutableArray *)commons {
    if (!_commons) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        _commons = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    return _commons;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.didLaunch) {
        [self fetchData];
    }
}

- (void)fetchData {
    if (!self.refreshControl.refreshing) {
        [self.refreshControl beginRefreshing];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.backupMenus = [NSMutableArray new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSDictionary *common in self.commons) {
            if ([common[@"shouldDisplay"] boolValue]) {
                [self.backupMenus addObject:[CLCommonsMenuFetcher fetchMenuForCommons:[common[@"ID"] integerValue] menuDay:CLCommonsMenuDayNext]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.didLaunch = YES;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self updateUI];
        });
    });
}

- (IBAction)filterAction:(UIBarButtonItem *)sender
{
    UIActionSheet *filterSheet = [[UIActionSheet alloc] initWithTitle:@"Choose filter" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"All meals", @"Vegetarian", @"Alcohol", @"Lactose Free", nil];
    
    [filterSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableArray *oldFilters = self.mealTagFilter;
    self.mealTagFilter = [NSMutableArray new];
    
    switch (buttonIndex) {
        case 0:
            // Reset: leave filters empty
            self.title = @"All Meals";
            break;
        case 1:
            [self.mealTagFilter addObject:@(CLCommonsMealTagVegetarian)];
            self.title = @"Vegetarian Meals";
            break;
        case 2:
            [self.mealTagFilter addObject:@(CLCommonsMealTagAlcohol)];
            self.title = @"Alcohol Meals";
            break;
        case 3:
            [self.mealTagFilter addObject:@(CLCommonsMealTagLactoseFree)];
            self.title = @"Lactose Free";
            break;
        
        default:
            // keep old filters
            self.mealTagFilter = oldFilters;
            
            break;
    }
    
    [self updateUI];
    
}

- (void)updateUI {
    if (self.refreshControl.refreshing) {
        [self.refreshControl endRefreshing];
    }
    
    if (self.mealTagFilter.count == 0) {
        // no need to filter
        self.activeMenus = [self.backupMenus copy];
    } else {
        // we need to apply filters
        
        NSMutableArray *filteredMenus = [NSMutableArray new];
        
        for (CLCommonsMenu *menu in self.backupMenus) {
            CLCommonsMenu *filteredMenu = [menu filteredMenuUsingTags:self.mealTagFilter];
            [filteredMenus addObject:filteredMenu];
        }
        
        self.activeMenus = filteredMenus;
    }
    
    [self.tableView reloadData];
}

-(IBAction)doRefresh:(id)sender
{
    [self fetchData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.activeMenus.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    CLCommonsMenu *tempMenu = self.activeMenus[section];
    return tempMenu.meals.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CLCommonsMenu *tempMenu = self.activeMenus[section];
    return tempMenu.commons;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CLCommonsMenu *tempMenu = self.activeMenus[section];
    return tempMenu.date;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    CLCommonsMenu *tempMenu = self.activeMenus[indexPath.section];
    CLCommonsMeal *tempMeal = tempMenu.meals[indexPath.row];

    cell.descriptionLabel.text = tempMeal.description;
    cell.priceLabel.text = tempMeal.prices.firstObject;
    
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"settings"]) {
        if ([segue.destinationViewController isKindOfClass:[SettingsTableViewController class]]) {
            SettingsTableViewController *tvc = segue.destinationViewController;
            tvc.commons = self.commons;
        }
    } if ([segue.identifier isEqualToString:@"details"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailsTableViewController class]]) {
            DetailsTableViewController *tvc = segue.destinationViewController;
            
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            CLCommonsMenu *tmpMenu = self.activeMenus[path.section];
            
            tvc.meal = tmpMenu.meals[path.row];
        }
    }
}

@end
