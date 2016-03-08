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

@implementation QuestionSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_QUESTION{ return @"Question"; }
+(NSString *)COL_CATEGORY_TITLE{ return @"title"; }
+(NSString *)COL_CATEGORY_VALUE{ return @"value"; }
+(NSString *)COL_CATEGORY_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_CATEGORY_UPDATED_AT{ return @"updated_at"; }
+(NSString *)COL_CATEGORY_QCM{ return @"qcm"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (void)insert:(Question *) question{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:QuestionSQLiteAdapter.TABLE_QUESTION inManagedObjectContext:context];
    
    [managedObject setValue:question.title forKey:QuestionSQLiteAdapter.COL_CATEGORY_TITLE];
    [managedObject setValue:[NSNumber numberWithInt:(question.value)] forKey:QuestionSQLiteAdapter.COL_CATEGORY_VALUE];
    [managedObject setValue:question.created_at forKey:QuestionSQLiteAdapter.COL_CATEGORY_CREATED_AT];
    [managedObject setValue:question.updated_at forKey:QuestionSQLiteAdapter.COL_CATEGORY_UPDATED_AT];
    [managedObject setValue:question.qcm forKey:QuestionSQLiteAdapter.COL_CATEGORY_QCM];
    
    [appDelegate saveContext];
}

- (NSArray*)getAll{
    
    NSArray* questions = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:QuestionSQLiteAdapter.TABLE_QUESTION inManagedObjectContext:context];
    
    questions = [context executeFetchRequest:fetchRequest error:nil];
    
    return questions;
    
}
- (NSManagedObject *)getById:(NSManagedObject *) question{
    
    NSManagedObject *managedObject = [context objectWithID:question.objectID];
    
    return managedObject;
}

@end
