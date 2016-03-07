//
//  QcmUser.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Qcm.h"

@interface QcmUser : NSObject

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Qcm *qcm;
@property (nonatomic) float note;
@property (nonatomic) Boolean is_done;

@end
