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
+(NSString *)COL_USER_NAME{ return @"name"; }
+(NSString *)COL_USER_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_USER_UPDATED_AT{ return @"updated_at"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (void)insert:(Group *) group{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:GroupSQLiteAdapter.TABLE_GROUP inManagedObjectContext:context];
    
    [managedObject setValue:group.name forKey:GroupSQLiteAdapter.COL_USER_NAME];
    [managedObject setValue:group.created_at forKey:GroupSQLiteAdapter.COL_USER_CREATED_AT];
    [managedObject setValue:group.updated_at forKey:GroupSQLiteAdapter.COL_USER_UPDATED_AT];
    
    [appDelegate saveContext];
}

- (NSArray*)getAll{
    
    NSArray* groups = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:GroupSQLiteAdapter.TABLE_GROUP inManagedObjectContext:context];
    
    groups = [context executeFetchRequest:fetchRequest error:nil];
    
    return groups;
    
}
- (NSManagedObject *)getById:(NSManagedObject *) group{
    
    NSManagedObject *managedObject = [context objectWithID:group.objectID];
    
    return managedObject;
}

- (NSManagedObject*)getByName:(Group *) group{
    
    //create a filter
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name LIKE %@", group.name];
    
    //create a query
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:GroupSQLiteAdapter.TABLE_GROUP];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute the query
    NSManagedObject *managedObject = [[context executeFetchRequest:request error:nil]objectAtIndex:0];
    
    return managedObject;
    
}

@end
