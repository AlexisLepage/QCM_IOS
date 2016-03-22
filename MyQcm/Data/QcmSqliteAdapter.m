//
//  QcmSQLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmSQLiteAdapter.h"
#import "Qcm.h"
#import "AppDelegate.h"
#import "CategorySQLiteAdapter.h"

@implementation QcmSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_QCM{ return @"Qcm"; }
+(NSString *)COL_QCM_IDSERVER{ return @"id_server"; }
+(NSString *)COL_QCM_NAME{ return @"name"; }
+(NSString *)COL_QCM_IS_AVAILABLE{ return @"is_available"; }
+(NSString *)COL_QCM_DURATION{ return @"duration"; }
+(NSString *)COL_QCM_BEGINNING_AT{ return @"beginning_at"; }
+(NSString *)COL_QCM_FINISHED_AT{ return @"finished_at"; }
+(NSString *)COL_QCM_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_QCM_UPDATED_AT{ return @"updated_at"; }
+(NSString *)COL_QCM_CATEGORY{ return @"category"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObject*)insert:(Qcm *) qcm{

    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:QcmSQLiteAdapter.TABLE_QCM inManagedObjectContext:context];
    
    [managedObject setValue:[NSNumber numberWithInt:(qcm.idServer)] forKey:QcmSQLiteAdapter.COL_QCM_IDSERVER];
    [managedObject setValue:qcm.name forKey:QcmSQLiteAdapter.COL_QCM_NAME];
    [managedObject setValue:[NSNumber numberWithBool:qcm.is_available] forKey:QcmSQLiteAdapter.COL_QCM_IS_AVAILABLE];
    [managedObject setValue:qcm.beginning_at forKey:QcmSQLiteAdapter.COL_QCM_BEGINNING_AT];
    [managedObject setValue:qcm.finished_at forKey:QcmSQLiteAdapter.COL_QCM_FINISHED_AT];
    [managedObject setValue:[NSNumber numberWithInt:(qcm.duration)] forKey:QcmSQLiteAdapter.COL_QCM_DURATION];
    [managedObject setValue:qcm.created_at forKey:QcmSQLiteAdapter.COL_QCM_CREATED_AT];
    [managedObject setValue:qcm.updated_at forKey:QcmSQLiteAdapter.COL_QCM_UPDATED_AT];
    
    if (qcm.category != nil) {
        
        CategorySQLiteAdapter* adapter = [CategorySQLiteAdapter new];
        NSManagedObject* categoryManagedObject = [adapter getByIdServer:qcm.category.idServer];
        
        if (categoryManagedObject == nil) {
            categoryManagedObject =[adapter insert:qcm.category];
        }
        [managedObject setValue:categoryManagedObject forKey:QcmSQLiteAdapter.COL_QCM_CATEGORY];
    }
    
    [appDelegate saveContext];
    
    return managedObject;
}

- (NSArray*)getAll{
    
    NSArray* qcms = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:QcmSQLiteAdapter.TABLE_QCM inManagedObjectContext:context];
    
    qcms = [context executeFetchRequest:fetchRequest error:nil];
    
    return qcms;

}

- (NSManagedObject*)getByIdServer:(int) idServer{

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_server = %d", idServer];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:QcmSQLiteAdapter.TABLE_QCM];
    
    request.predicate = predicate;

    NSArray* result = [context executeFetchRequest:request error:nil];
    NSManagedObject *managedObject = nil;
    
    if (result.count > 0) {
         managedObject = [result objectAtIndex:0];
    }
    
    return managedObject;
}

@end
