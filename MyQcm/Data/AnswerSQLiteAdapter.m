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

@implementation AnswerSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_ANSWER{ return @"Answer"; }
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

- (void)insert:(Answer *) answer{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:AnswerSQLiteAdapter.TABLE_ANSWER inManagedObjectContext:context];
    
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
- (NSManagedObject *)getById:(NSManagedObject *) answer{
    
    NSManagedObject *managedObject = [context objectWithID:answer.objectID];
    
    return managedObject;
}

- (void)update:(NSManagedObject *) managedObject withAnswer:(Answer *)answer{
    
    //UPDATE IN TABLE
    [managedObject setValue:answer.title forKey:AnswerSQLiteAdapter.COL_ANSWER_TITLE];
    [managedObject setValue:[NSNumber numberWithBool:answer.is_valid] forKey:AnswerSQLiteAdapter.COL_ANSWER_IS_VALID];
    [managedObject setValue:answer.created_at forKey:AnswerSQLiteAdapter.COL_ANSWER_CREATED_AT];
    [managedObject setValue:answer.updated_at forKey:AnswerSQLiteAdapter.COL_ANSWER_UPDATED_AT];
    [managedObject setValue:answer.question forKey:AnswerSQLiteAdapter.COL_ANSWER_QUESTION];
    
    //SAVE IN DB
    [appDelegate saveContext];
    
}

@end
