//
//  GroupSQLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "GroupSQLiteAdapter.h"
#import "Group.h"
#import "AppDelegate.h"

@implementation GroupSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_GROUP{ return @"Group"; }
+(NSString *)COL_GROUP_IDSERVER{ return @"id_server"; }
+(NSString *)COL_GROUP_NAME{ return @"name"; }
+(NSString *)COL_GROUP_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_GROUP_UPDATED_AT{ return @"updated_at"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObject*)insert:(Group *) group{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:GroupSQLiteAdapter.TABLE_GROUP inManagedObjectContext:context];
    
    [managedObject setValue:[NSNumber numberWithInt:(group.idServer)] forKey:GroupSQLiteAdapter.COL_GROUP_IDSERVER];
    [managedObject setValue:group.name forKey:GroupSQLiteAdapter.COL_GROUP_NAME];
    [managedObject setValue:group.created_at forKey:GroupSQLiteAdapter.COL_GROUP_CREATED_AT];
    [managedObject setValue:group.updated_at forKey:GroupSQLiteAdapter.COL_GROUP_UPDATED_AT];
    
    [appDelegate saveContext];
    
    return managedObject;
}

- (NSArray*)getAll{
    
    NSArray* groups = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:GroupSQLiteAdapter.TABLE_GROUP inManagedObjectContext:context];
    
    groups = [context executeFetchRequest:fetchRequest error:nil];
    
    return groups;
    
}

- (NSManagedObject*)getByIdServer: (int) idServer{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_server = %d", idServer];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:GroupSQLiteAdapter.TABLE_GROUP];
    
    request.predicate = predicate;
    
    NSArray* result = [context executeFetchRequest:request error:nil];
    NSManagedObject *managedObject = nil;
    
    if (result.count > 0) {
        managedObject = [result objectAtIndex:0];
    }
    
    return managedObject;
}

@end
