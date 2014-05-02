//
//  DetailsTableViewController.m
//  Commons
//
//  Created by Florian Letsch on 28/04/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "DetailsTableViewController.h"

@interface DetailsTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation DetailsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.descriptionLabel.text = self.meal.description;
    self.categoryLabel.text = self.meal.category;
    self.priceLabel.text = self.meal.prices.firstObject;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

@end
