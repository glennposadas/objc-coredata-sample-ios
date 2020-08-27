//
//  AddContactViewController.h
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddContactViewController : UIViewController

typedef void(^AddContactBlock)(NSData *imageData, NSString *name, NSString *phone, NSString *email);
@property (nonatomic, copy) AddContactBlock contactBlock;

@end

NS_ASSUME_NONNULL_END
