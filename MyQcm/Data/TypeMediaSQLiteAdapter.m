//
//  TypeMediaSQLiteAdapter.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "TypeMediaSQLiteAdapter.h"
#import "TypeMedia.h"
#import "AppDelegate.h"

@implementation TypeMediaSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_TYPEMEDIA{ return @"TypeMedia"; }
+(NSString *)COL_TYPEMEDIA_NAME{ return @"name"; }

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (void)insert:(TypeMedia *) typeMedia{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:TypeMediaSQLiteAdapter.TABLE_TYPEMEDIA inManagedObjectContext:context];
    
    [managedObject setValue:typeMedia.name forKey:TypeMediaSQLiteAdapter.COL_TYPEMEDIA_NAME];
    
    [appDelegate saveContext];
}

- (NSArray*)getAll{
    
    NSArray* typeMedias = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:TypeMediaSQLiteAdapter.TABLE_TYPEMEDIA inManagedObjectContext:context];
    
    typeMedias = [context executeFetchRequest:fetchRequest error:nil];
    
    return typeMedias;
    
}
- (NSManagedObject *)getById:(NSManagedObject *) typeMedia{
    
    NSManagedObject *managedObject = [context objectWithID:typeMedia.objectID];
    
    return managedObject;
}
@end
