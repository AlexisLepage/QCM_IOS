//
//  GroupSQLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Group.h"

@interface GroupSQLiteAdapter : NSObject

+ (NSString *) TABLE_GROUP;
+ (NSString *) COL_GROUP_IDSERVER;
+ (NSString *) COL_GROUP_NAME;
+ (NSString *) COL_GROUP_CREATED_AT;
+ (NSString *) COL_GROUP_UPDATED_AT;

- (NSManagedObject*)insert:(Group *)group;
- (NSArray*)getAll;
- (NSManagedObject *)getByIdServer:(int) idServer;

@end
