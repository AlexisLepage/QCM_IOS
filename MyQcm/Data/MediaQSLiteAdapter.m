//
//  MediaQSLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "MediaQSLiteAdapter.h"
#import "Media.h"
#import "AppDelegate.h"
#import "QuestionSQLiteAdapter.h"
#import "TypeMediaSQLiteAdapter.h"

@implementation MediaQSLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_MEDIA{ return @"Media"; }
+(NSString *)COL_MEDIA_IDSERVER{ return @"id_server"; }
+(NSString *)COL_MEDIA_NAME{ return @"name"; }
+(NSString *)COL_MEDIA_URL{ return @"url"; }
+(NSString *)COL_MEDIA_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_MEDIA_UPDATED_AT{ return @"updated_at"; }
+(NSString *)COL_MEDIA_QUESTION{ return @"question"; }
+(NSString *)COL_MEDIA_TYPEMEDIA{ return @"type_media"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObject*)insert:(Media *) media{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:MediaQSLiteAdapter.TABLE_MEDIA inManagedObjectContext:context];
    
    [managedObject setValue:[NSNumber numberWithInt:(media.idServer)] forKey:MediaQSLiteAdapter.COL_MEDIA_IDSERVER];
    [managedObject setValue:media.name forKey:MediaQSLiteAdapter.COL_MEDIA_NAME];
    [managedObject setValue:media.url forKey:MediaQSLiteAdapter.COL_MEDIA_URL];
    [managedObject setValue:media.created_at forKey:MediaQSLiteAdapter.COL_MEDIA_CREATED_AT];
    [managedObject setValue:media.updated_at forKey:MediaQSLiteAdapter.COL_MEDIA_UPDATED_AT];
    
    if (media.question != nil) {
        
        QuestionSQLiteAdapter* adapter = [QuestionSQLiteAdapter new];
        NSManagedObject* questionManagedObject = [adapter getByIdServer:media.question.idServer];
        
        if (questionManagedObject == nil) {
            questionManagedObject =[adapter insert:media.question];
        }
        [managedObject setValue:questionManagedObject forKey:MediaQSLiteAdapter.COL_MEDIA_QUESTION];
    }
    
    if (media.type_media != nil) {
        
        TypeMediaSQLiteAdapter* adapter = [TypeMediaSQLiteAdapter new];
        NSManagedObject* typeMediaManagedObject = [adapter getByIdServer:media.type_media.idServer];
        
        if (typeMediaManagedObject == nil) {
            typeMediaManagedObject =[adapter insert:media.type_media];
        }
        [managedObject setValue:typeMediaManagedObject forKey:MediaQSLiteAdapter.COL_MEDIA_TYPEMEDIA];
    }

    
    [appDelegate saveContext];
    
    return managedObject;
}

- (NSArray*)getAll{
    
    NSArray* medias = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:MediaQSLiteAdapter.TABLE_MEDIA inManagedObjectContext:context];
    
    medias = [context executeFetchRequest:fetchRequest error:nil];
    
    return medias;
    
}

- (NSManagedObject*)getByIdServer:(int) idServer{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_server = %d", idServer];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MediaQSLiteAdapter.TABLE_MEDIA];
    
    request.predicate = predicate;
    
    NSArray* result = [context executeFetchRequest:request error:nil];
    NSManagedObject *managedObject = nil;
    
    if (result.count > 0) {
        managedObject = [result objectAtIndex:0];
    }
    
    return managedObject;
}


@end
