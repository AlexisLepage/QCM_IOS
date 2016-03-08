//
//  MediaQSLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Media.h"

@interface MediaQSLiteAdapter : NSObject

+ (NSString *) TABLE_MEDIA;
+ (NSString *) COL_MEDIA_NAME;
+ (NSString *) COL_MEDIA_URL;
+ (NSString *) COL_MEDIA_CREATED_AT;
+ (NSString *) COL_MEDIA_UPDATED_AT;
+ (NSString *) COL_MEDIA_QUESTION;
+ (NSString *) COL_MEDIA_TYPEMEDIA;

- (void)insert:(Media *)media;
- (NSArray*)getAll;
- (NSManagedObject *)getById:(NSManagedObject *) media;

@end
