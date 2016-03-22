//
//  QcmSQLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Qcm.h"

@interface QcmSQLiteAdapter : NSObject

+ (NSString *) TABLE_QCM;
+ (NSString *) COL_QCM_IDSERVER;
+ (NSString *) COL_QCM_NAME;
+ (NSString *) COL_QCM_IS_AVAILABLE;
+ (NSString *) COL_QCM_BEGINNING_AT;
+ (NSString *) COL_QCM_FINISHED_AT;
+ (NSString *) COL_QCM_DURATION;
+ (NSString *) COL_QCM_CREATED_AT;
+ (NSString *) COL_QCM_UPDATED_AT;
+ (NSString *) COL_QCM_CATEGORY;

- (NSManagedObject*)insert:(Qcm *)qcm;
- (NSArray*)getAll;
- (NSManagedObject*)getByIdServer:(int) idServer;

@end
