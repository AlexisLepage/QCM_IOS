//
//  QcmUserSQLiteAdapter.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "QcmUser.h"

@interface QcmUserSQLiteAdapter : NSObject

+ (NSString *) TABLE_QCMUSER;
+ (NSString *) COL_QCMUSER_IDSERVER;
+ (NSString *) COL_QCMUSER_NOTE;
+ (NSString *) COL_QCMUSER_IS_DONE;
+ (NSString *) COL_QCMUSER_QCM;
+ (NSString *) COL_QCMUSER_USER;

- (NSManagedObject*)insert:(QcmUser *)qcmUser;
- (NSArray*)getAll;
- (NSManagedObject *)getByIdServer:(int) idServer;

@end
