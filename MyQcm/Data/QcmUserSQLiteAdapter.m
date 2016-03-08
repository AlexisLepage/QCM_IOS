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

@implementation QcmUserSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_QCMUSER{ return @"QcmUser"; }
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

- (void)insert:(QcmUser *) qcmUser{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:QcmUserSQLiteAdapter.TABLE_QCMUSER inManagedObjectContext:context];
    
    [managedObject setValue:[NSNumber numberWithInt:(qcmUser.note)] forKey:QcmUserSQLiteAdapter.COL_QCMUSER_NOTE];
    [managedObject setValue:[NSNumber numberWithBool:qcmUser.is_done] forKey:QcmUserSQLiteAdapter.COL_QCMUSER_IS_DONE];
    [managedObject setValue:qcmUser.qcm forKey:QcmUserSQLiteAdapter.COL_QCMUSER_QCM];
    [managedObject setValue:qcmUser.user forKey:QcmUserSQLiteAdapter.COL_QCMUSER_USER];
    
    [appDelegate saveContext];
}

- (NSArray*)getAll{
    
    NSArray* qcmUsers = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:QcmUserSQLiteAdapter.TABLE_QCMUSER inManagedObjectContext:context];
    
    qcmUsers = [context executeFetchRequest:fetchRequest error:nil];
    
    return qcmUsers;
    
}
- (NSManagedObject *)getById:(NSManagedObject *) qcmUser{
    
    NSManagedObject *managedObject = [context objectWithID:qcmUser.objectID];
    
    return managedObject;
}
@end
