//
//  CategorySQLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CategoryQcm.h"

@interface CategorySQLiteAdapter : NSObject

+ (NSString *) TABLE_CATEGORY;
+ (NSString *) COL_CATEGORY_IDSERVER;
+ (NSString *) COL_CATEGORY_NAME;
+ (NSString *) COL_CATEGORY_CREATED_AT;
+ (NSString *) COL_CATEGORY_UPDATED_AT;

- (NSManagedObject*)insert:(CategoryQcm *)category;
- (NSArray*)getAll;
- (NSManagedObject *)getByIdServer:(int) idServer;

@end
