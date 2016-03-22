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
+ (NSString *) COL_QUESTION_IDSERVER;
+ (NSString *) COL_QUESTION_TITLE;
+ (NSString *) COL_QUESTION_VALUE;
+ (NSString *) COL_QUESTION_CREATED_AT;
+ (NSString *) COL_QUESTION_UPDATED_AT;
+ (NSString *) COL_QUESTION_QCM;

- (NSManagedObject*)insert:(Question *)question;
- (NSArray*)getAll;
- (NSManagedObject *)getByIdServer:(int) idServer;

@end
