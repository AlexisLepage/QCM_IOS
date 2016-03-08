//
//  AnswerSQLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Answer.h"

@interface AnswerSQLiteAdapter : NSObject

+ (NSString *) TABLE_ANSWER;
+ (NSString *) COL_ANSWER_TITLE;
+ (NSString *) COL_ANSWER_IS_VALID;
+ (NSString *) COL_ANSWER_CREATED_AT;
+ (NSString *) COL_ANSWER_UPDATED_AT;
+ (NSString *) COL_ANSWER_QUESTION;

- (void)insert:(Answer *)answer;
- (NSArray*)getAll;
- (NSManagedObject *)getById:(NSManagedObject *) answer;
- (void)update:(NSManagedObject *) managedObject withAnswer:(Answer *) answer;

@end
