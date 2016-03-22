//
//  CategorySQLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "CategorySQLiteAdapter.h"
#import "CategoryQcm.h"
#import "AppDelegate.h"

@implementation CategorySQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_CATEGORY{ return @"Category"; }
+(NSString *)COL_CATEGORY_IDSERVER{ return @"id_server"; }
+(NSString *)COL_CATEGORY_NAME{ return @"name"; }
+(NSString *)COL_CATEGORY_CREATED_AT{ return @"created_at"; }
+(NSString *)COL_CATEGORY_UPDATED_AT{ return @"updated_at"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObject *)insert:(CategoryQcm *) category{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:CategorySQLiteAdapter.TABLE_CATEGORY inManagedObjectContext:context];
    [managedObject setValue:[NSNumber numberWithInt:(category.idServer)] forKey:CategorySQLiteAdapter.COL_CATEGORY_IDSERVER];
    [managedObject setValue:category.name forKey:CategorySQLiteAdapter.COL_CATEGORY_NAME];
    [managedObject setValue:category.created_at forKey:CategorySQLiteAdapter.COL_CATEGORY_CREATED_AT];
    [managedObject setValue:category.updated_at forKey:CategorySQLiteAdapter.COL_CATEGORY_UPDATED_AT];
    
    [appDelegate saveContext];
    
    return managedObject;
}


- (NSArray*)getAll{
    
    NSArray* categories = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:CategorySQLiteAdapter.TABLE_CATEGORY inManagedObjectContext:context];
    
    categories = [context executeFetchRequest:fetchRequest error:nil];
    
    return categories;
    
}

- (NSManagedObject*)getByIdServer:(int) idServer{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_server = %d", idServer];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CategorySQLiteAdapter.TABLE_CATEGORY];
    
    request.predicate = predicate;
    
    NSArray* result = [context executeFetchRequest:request error:nil];
    NSManagedObject *managedObject = nil;
    
    if (result.count > 0) {
        managedObject = [result objectAtIndex:0];
    }
    
    return managedObject;
}


@end
