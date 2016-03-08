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
+ (NSString *) COL_USER_NAME;
+ (NSString *) COL_USER_CREATED_AT;
+ (NSString *) COL_USER_UPDATED_AT;

- (void)insert:(Group *)group;
- (NSArray*)getAll;
- (NSManagedObject *)getById:(NSManagedObject *) group;
- (NSManagedObject *)getByName:(Group *) group;

@end
