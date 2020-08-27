//
//  ContactTableViewCell.m
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

#import "ContactTableViewCell.h"

@interface ContactTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView_ProfilePhoto;
@property (weak, nonatomic) IBOutlet UILabel *label_Name;
@property (weak, nonatomic) IBOutlet UILabel *label_Phone;
@property (weak, nonatomic) IBOutlet UILabel *label_Email;

@end

@implementation ContactTableViewCell

- (void)setupCellWithContact:(Contact *)contact {
    UIImage *profilePhoto = [UIImage imageWithData:contact.photo];
    self.imageView_ProfilePhoto.image = profilePhoto;
    
    self.label_Name.text = contact.name;
    self.label_Phone.text = contact.details.phone;
    self.label_Email.text = contact.details.email;
}

@end
