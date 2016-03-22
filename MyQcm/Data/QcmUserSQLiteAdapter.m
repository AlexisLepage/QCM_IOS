//
//  QcmUserSQLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmUserSQLiteAdapter.h"
#import "QcmUser.h"
#import "AppDelegate.h"
#import "QcmSQLiteAdapter.h"
#import "UserSQLiteAdapter.h"

@implementation QcmUserSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_QCMUSER{ return @"QcmUser"; }
+(NSString *)COL_QCMUSER_IDSERVER{ return @"id_server"; }
+(NSString *)COL_QCMUSER_NOTE{ return @"note"; }
+(NSString *)COL_QCMUSER_IS_DONE{ return @"is_done"; }
+(NSString *)COL_QCMUSER_QCM{ return @"qcm"; }
+(NSString *)COL_QCMUSER_USER{ return @"user"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObject*)insert:(QcmUser *) qcmUser{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:QcmUserSQLiteAdapter.TABLE_QCMUSER inManagedObjectContext:context];
    
    [managedObject setValue:[NSNumber numberWithInt:(qcmUser.idServer)] forKey:QcmUserSQLiteAdapter.COL_QCMUSER_IDSERVER];
    [managedObject setValue:[NSNumber numberWithInt:(qcmUser.note)] forKey:QcmUserSQLiteAdapter.COL_QCMUSER_NOTE];
    [managedObject setValue:[NSNumber numberWithBool:qcmUser.is_done] forKey:QcmUserSQLiteAdapter.COL_QCMUSER_IS_DONE];
    
    if (qcmUser.qcm != nil) {
        
        QcmSQLiteAdapter* adapter = [QcmSQLiteAdapter new];
        NSManagedObject* qcmManagedObject = [adapter getByIdServer:qcmUser.qcm.idServer];
        
        if (qcmManagedObject == nil) {
            qcmManagedObject =[adapter insert:qcmUser.qcm];
        }
        [managedObject setValue:qcmManagedObject forKey:QcmUserSQLiteAdapter.COL_QCMUSER_QCM];
    }
    
    if (qcmUser.user != nil) {
        
        UserSQLiteAdapter* adapter = [UserSQLiteAdapter new];
        NSManagedObject* userManagedObject = [adapter getByIdServer:qcmUser.user.idServer];
        
        if (userManagedObject == nil) {
            userManagedObject =[adapter insert:qcmUser.user];
        }
        [managedObject setValue:userManagedObject forKey:QcmUserSQLiteAdapter.COL_QCMUSER_USER];
    }
    
    [appDelegate saveContext];
    
    return managedObject;
}

- (NSArray*)getAll{
    
    NSArray* qcmUsers = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:QcmUserSQLiteAdapter.TABLE_QCMUSER inManagedObjectContext:context];
    
    qcmUsers = [context executeFetchRequest:fetchRequest error:nil];
    
    return qcmUsers;
    
}

- (NSManagedObject*)getByIdServer:(int) idServer{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_server = %d", idServer];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:QcmUserSQLiteAdapter.TABLE_QCMUSER];
    
    request.predicate = predicate;
    
    NSArray* result = [context executeFetchRequest:request error:nil];
    NSManagedObject *managedObject = nil;
    
    if (result.count > 0) {
        managedObject = [result objectAtIndex:0];
    }
    
    return managedObject;
}

@end
