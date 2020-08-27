//
//  ContactTableViewCell.h
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

#import "Details+CoreDataProperties.h"
#import "Contact+CoreDataProperties.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactTableViewCell : UITableViewCell
- (void)setupCellWithContact:(Contact *)contact;
@end

NS_ASSUME_NONNULL_END
