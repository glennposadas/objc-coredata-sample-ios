//
//  Details+CoreDataProperties.h
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//
//

#import "Details+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Details (CoreDataProperties)

+ (NSFetchRequest<Details *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, retain) Contact *contact;

@end

NS_ASSUME_NONNULL_END
