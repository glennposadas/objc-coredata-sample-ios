//
//  Contact+CoreDataProperties.m
//  FastCDSAmple
//
//  Created by Glenn Von Posadas on 8/27/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//
//

#import "Contact+CoreDataProperties.h"

@implementation Contact (CoreDataProperties)

+ (NSFetchRequest<Contact *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Contact"];
}

@dynamic name;
@dynamic photo;
@dynamic details;

@end
