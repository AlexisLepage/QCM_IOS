//
//  TypeMediaSQLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TypeMedia.h"

@interface TypeMediaSQLiteAdapter : NSObject

+ (NSString *) TABLE_TYPEMEDIA;
+ (NSString *) COL_TYPEMEDIA_IDSERVER;
+ (NSString *) COL_TYPEMEDIA_NAME;

- (NSManagedObject*)insert:(TypeMedia *)typeMedia;
- (NSArray*)getAll;
- (NSManagedObject *)getByIdServer:(int) idServer;

@end
