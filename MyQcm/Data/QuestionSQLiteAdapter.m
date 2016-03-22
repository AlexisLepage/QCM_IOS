//
//  QuestionSQLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QuestionSQLiteAdapter.h"
#import "Question.h"
#import "AppDelegate.h"
#import "QcmSQLiteAdapter.h"

@implementation QuestionSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_QUESTION{ return @"Question"; }
+(NSString *)COL_QUESTION_IDSERVER{ return @"id_server"; }
+(NSString *)COL_QUESTION_TITLE{ return @"title"; }
+(NSString *)COL_QUESTION_VALUE{ return @"value"; }
+(NSString *)COL_QUESTION_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_QUESTION_UPDATED_AT{ return @"updated_at"; }
+(NSString *)COL_QUESTION_QCM{ return @"qcm"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObject*)insert:(Question *) question{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:QuestionSQLiteAdapter.TABLE_QUESTION inManagedObjectContext:context];
    
    [managedObject setValue:[NSNumber numberWithInt:(question.idServer)] forKey:QuestionSQLiteAdapter.COL_QUESTION_IDSERVER];
    [managedObject setValue:question.title forKey:QuestionSQLiteAdapter.COL_QUESTION_TITLE];
    [managedObject setValue:[NSNumber numberWithInt:(question.value)] forKey:QuestionSQLiteAdapter.COL_QUESTION_VALUE];
    [managedObject setValue:question.created_at forKey:QuestionSQLiteAdapter.COL_QUESTION_CREATED_AT];
    [managedObject setValue:question.updated_at forKey:QuestionSQLiteAdapter.COL_QUESTION_UPDATED_AT];
    
    if (question.qcm != nil) {
        
        QcmSQLiteAdapter* adapter = [QcmSQLiteAdapter new];
        NSManagedObject* qcmManagedObject = [adapter getByIdServer:question.qcm.idServer];
        
        if (qcmManagedObject == nil) {
            qcmManagedObject =[adapter insert:question.qcm];
        }
        [managedObject setValue:qcmManagedObject forKey:QuestionSQLiteAdapter.COL_QUESTION_QCM];
    }
    
    [appDelegate saveContext];
    
    return managedObject;
}

- (NSArray*)getAll{
    
    NSArray* questions = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:QuestionSQLiteAdapter.TABLE_QUESTION inManagedObjectContext:context];
    
    questions = [context executeFetchRequest:fetchRequest error:nil];
    
    return questions;
    
}

- (NSManagedObject*)getByIdServer:(int) idServer{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_server = %d", idServer];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:QuestionSQLiteAdapter.TABLE_QUESTION];
    
    request.predicate = predicate;
    
    NSArray* result = [context executeFetchRequest:request error:nil];
    NSManagedObject *managedObject = nil;
    
    if (result.count > 0) {
        managedObject = [result objectAtIndex:0];
    }
    
    return managedObject;
}

@end
