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

@implementation MediaQSLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

+(NSString *)TABLE_MEDIA{ return @"Media"; }
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

- (void)insert:(Media *) media{
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:MediaQSLiteAdapter.TABLE_MEDIA inManagedObjectContext:context];
    
    [managedObject setValue:media.name forKey:MediaQSLiteAdapter.COL_MEDIA_NAME];
    [managedObject setValue:media.url forKey:MediaQSLiteAdapter.COL_MEDIA_URL];
    [managedObject setValue:media.created_at forKey:MediaQSLiteAdapter.COL_MEDIA_CREATED_AT];
    [managedObject setValue:media.updated_at forKey:MediaQSLiteAdapter.COL_MEDIA_UPDATED_AT];
    [managedObject setValue:media.question forKey:MediaQSLiteAdapter.COL_MEDIA_QUESTION];
    [managedObject setValue:media.type_media forKey:MediaQSLiteAdapter.COL_MEDIA_TYPEMEDIA];
    
    [appDelegate saveContext];
}

- (NSArray*)getAll{
    
    NSArray* medias = [NSArray new];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    fetchRequest.entity = [NSEntityDescription entityForName:MediaQSLiteAdapter.TABLE_MEDIA inManagedObjectContext:context];
    
    medias = [context executeFetchRequest:fetchRequest error:nil];
    
    return medias;
    
}
- (NSManagedObject *)getById:(NSManagedObject *) media{
    
    NSManagedObject *managedObject = [context objectWithID:media.objectID];
    
    return managedObject;
}


@end
