//
//  MenuTableViewCell.h
//  Commons
//
//  Created by Florian Letsch on 23/04/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewCell.h"

@interface MenuTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic) IBOutlet UILabel *priceLabel;

@end
