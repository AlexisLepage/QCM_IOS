//
//  AnswerSQLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "AnswerSQLiteAdapter.h"
#import "Answer.h"
#import "AppDelegate.h"
#import "QuestionSQLiteAdapter.h"

@implementation AnswerSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_ANSWER{ return @"Answer"; }
+(NSString *)COL_ANSWER_IDSERVER{ return @"id_server"; }
+(NSString *)COL_ANSWER_TITLE{ return @"title"; }
+(NSString *)COL_ANSWER_IS_VALID{ return @"is_valid"; }
+(NSString *)COL_ANSWER_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_ANSWER_UPDATED_AT{ return @"updated_at"; }
+(NSString *)COL_ANSWER_QUESTION{ return @"question"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObject*)insert:(Answer *) answer{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:AnswerSQLiteAdapter.TABLE_ANSWER inManagedObjectContext:context];
    
    [managedObject setValue:[NSNumber numberWithInt:(answer.idServer)] forKey:AnswerSQLiteAdapter.COL_ANSWER_IDSERVER];
    [managedObject setValue:answer.title forKey:AnswerSQLiteAdapter.COL_ANSWER_TITLE];
    [managedObject setValue:[NSNumber numberWithBool:answer.is_valid] forKey:AnswerSQLiteAdapter.COL_ANSWER_IS_VALID];
    [managedObject setValue:answer.created_at forKey:AnswerSQLiteAdapter.COL_ANSWER_CREATED_AT];
    [managedObject setValue:answer.updated_at forKey:AnswerSQLiteAdapter.COL_ANSWER_UPDATED_AT];
    
    if (answer.question != nil) {
        
        QuestionSQLiteAdapter* adapter = [QuestionSQLiteAdapter new];
        NSManagedObject* questionManagedObject = [adapter getByIdServer:answer.question.idServer];
        
        if (questionManagedObject == nil) {
            questionManagedObject =[adapter insert:answer.question];
        }
        [managedObject setValue:questionManagedObject forKey:AnswerSQLiteAdapter.COL_ANSWER_QUESTION];
    }

    
    [appDelegate saveContext];
    return managedObject;
}

- (void)update:(NSManagedObject *) managedObject withAnswer:(Answer *)answer{
    
    [managedObject setValue:answer.title forKey:AnswerSQLiteAdapter.COL_ANSWER_TITLE];
    [managedObject setValue:[NSNumber numberWithBool:answer.is_valid] forKey:AnswerSQLiteAdapter.COL_ANSWER_IS_VALID];
    [managedObject setValue:answer.created_at forKey:AnswerSQLiteAdapter.COL_ANSWER_CREATED_AT];
    [managedObject setValue:answer.updated_at forKey:AnswerSQLiteAdapter.COL_ANSWER_UPDATED_AT];
    [managedObject setValue:answer.question forKey:AnswerSQLiteAdapter.COL_ANSWER_QUESTION];
    
    [appDelegate saveContext];
    
}

- (NSArray*)getAll{
    
    NSArray* answers = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:AnswerSQLiteAdapter.TABLE_ANSWER inManagedObjectContext:context];
    
    answers = [context executeFetchRequest:fetchRequest error:nil];
    
    return answers;
    
}

- (NSManagedObject*)getByIdServer:(int) idServer{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_server = %d", idServer];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:AnswerSQLiteAdapter.TABLE_ANSWER];
    
    request.predicate = predicate;
    
    NSArray* result = [context executeFetchRequest:request error:nil];
    NSManagedObject *managedObject = nil;
    
    if (result.count > 0) {
        managedObject = [result objectAtIndex:0];
    }
    
    return managedObject;
}

@end
