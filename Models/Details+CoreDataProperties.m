//
//  Details+CoreDataProperties.m
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//
//

#import "Details+CoreDataProperties.h"

@implementation Details (CoreDataProperties)

+ (NSFetchRequest<Details *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Details"];
}

@dynamic email;
@dynamic phone;
@dynamic contact;

@end
