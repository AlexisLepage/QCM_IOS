//
//  UserSQLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@interface UserSQLiteAdapter : NSObject

+ (NSString *) TABLE_USER;
+ (NSString *) COL_USER_IDSERVER;
+ (NSString *) COL_USER_NAME;
+ (NSString *) COL_USER_FIRSTNAME;
+ (NSString *) COL_USER_EMAIL;
+ (NSString *) COL_USER_PASSWORD;
+ (NSString *) COL_USER_TOKEN;
+ (NSString *) COL_USER_CREATED_AT;
+ (NSString *) COL_USER_UPDATED_AT;
+ (NSString *) COL_USER_GROUP;

- (NSManagedObject*)insert:(User *)user;
- (NSArray*)getAll;
- (NSManagedObject *)getByIdServer:(int) idServer;

@end
