//
//  QuestionSQLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Question.h"

@interface QuestionSQLiteAdapter : NSObject

+ (NSString *) TABLE_QUESTION;
+ (NSString *) COL_CATEGORY_TITLE;
+ (NSString *) COL_CATEGORY_VALUE;
+ (NSString *) COL_CATEGORY_CREATED_AT;
+ (NSString *) COL_CATEGORY_UPDATED_AT;
+ (NSString *) COL_CATEGORY_QCM;

- (void)insert:(Question *)question;
- (NSArray*)getAll;
- (NSManagedObject *)getById:(NSManagedObject *) question;

@end
