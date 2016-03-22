//
//  UserSQLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "UserSQLiteAdapter.h"
#import "User.h"
#import "AppDelegate.h"
#import "GroupSQLiteAdapter.h"

@implementation UserSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_USER{ return @"User"; }
+(NSString *)COL_USER_IDSERVER{ return @"id_server"; }
+(NSString *)COL_USER_NAME{ return @"name"; }
+(NSString *)COL_USER_FIRSTNAME{ return @"firstname"; }
+(NSString *)COL_USER_EMAIL{ return @"email"; }
+(NSString *)COL_USER_PASSWORD{ return @"password"; }
+(NSString *)COL_USER_TOKEN{ return @"token"; }
+(NSString *)COL_USER_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_USER_UPDATED_AT{ return @"updated_at"; }
+(NSString *)COL_USER_GROUP{ return @"group"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObject*)insert:(User *) user{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:UserSQLiteAdapter.TABLE_USER inManagedObjectContext:context];
    
    [managedObject setValue:[NSNumber numberWithInt:(user.idServer)] forKey:UserSQLiteAdapter.COL_USER_IDSERVER];
    [managedObject setValue:user.name forKey:UserSQLiteAdapter.COL_USER_NAME];
    [managedObject setValue:user.firstname forKey:UserSQLiteAdapter.COL_USER_FIRSTNAME];
    [managedObject setValue:user.email forKey:UserSQLiteAdapter.COL_USER_EMAIL];
    [managedObject setValue:user.password forKey:UserSQLiteAdapter.COL_USER_PASSWORD];
    [managedObject setValue:user.token forKey:UserSQLiteAdapter.COL_USER_TOKEN];
    [managedObject setValue:user.created_at forKey:UserSQLiteAdapter.COL_USER_CREATED_AT];
    [managedObject setValue:user.updated_at forKey:UserSQLiteAdapter.COL_USER_UPDATED_AT];
    
    if (user.group != nil) {
        
        GroupSQLiteAdapter* adapter = [GroupSQLiteAdapter new];
        NSManagedObject* groupManagedObject = [adapter getByIdServer:user.group.idServer];
        
        if (groupManagedObject == nil) {
            groupManagedObject =[adapter insert:user.group];
        }
        [managedObject setValue:groupManagedObject forKey:UserSQLiteAdapter.COL_USER_GROUP];
    }

    [appDelegate saveContext];
    
    return managedObject;
}

- (NSArray*)getAll{
    
    NSArray* users = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:UserSQLiteAdapter.TABLE_USER inManagedObjectContext:context];
    
    users = [context executeFetchRequest:fetchRequest error:nil];
    
    return users;
    
}

- (NSManagedObject*)getByIdServer:(int) idServer{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_server = %d", idServer];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:UserSQLiteAdapter.TABLE_USER];
    
    request.predicate = predicate;
    
    NSArray* result = [context executeFetchRequest:request error:nil];
    NSManagedObject *managedObject = nil;
    
    if (result.count > 0) {
        managedObject = [result objectAtIndex:0];
    }
    
    return managedObject;
}

@end
