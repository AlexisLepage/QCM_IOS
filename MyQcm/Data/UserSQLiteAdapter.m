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

@implementation UserSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_USER{ return @"User"; }
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

- (void)insert:(User *) user{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:UserSQLiteAdapter.TABLE_USER inManagedObjectContext:context];
    
    [managedObject setValue:user.name forKey:UserSQLiteAdapter.COL_USER_NAME];
    [managedObject setValue:user.firstname forKey:UserSQLiteAdapter.COL_USER_FIRSTNAME];
    [managedObject setValue:user.email forKey:UserSQLiteAdapter.COL_USER_EMAIL];
    [managedObject setValue:user.password forKey:UserSQLiteAdapter.COL_USER_PASSWORD];
    [managedObject setValue:user.token forKey:UserSQLiteAdapter.COL_USER_TOKEN];
    [managedObject setValue:user.created_at forKey:UserSQLiteAdapter.COL_USER_CREATED_AT];
    [managedObject setValue:user.updated_at forKey:UserSQLiteAdapter.COL_USER_UPDATED_AT];
    [managedObject setValue:user.group forKey:UserSQLiteAdapter.COL_USER_GROUP];
    
    [appDelegate saveContext];
}

- (NSArray*)getAll{
    
    NSArray* users = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:UserSQLiteAdapter.TABLE_USER inManagedObjectContext:context];
    
    users = [context executeFetchRequest:fetchRequest error:nil];
    
    return users;
    
}
- (NSManagedObject *)getById:(NSManagedObject *) user{
    
    NSManagedObject *managedObject = [context objectWithID:user.objectID];
    
    return managedObject;
}
@end
