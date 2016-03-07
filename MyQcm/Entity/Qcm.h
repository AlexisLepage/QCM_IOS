//
//  Qcm.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryQcm.h"

@interface Qcm : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) Boolean is_available;
@property (nonatomic, strong) NSDate *beginning_at;
@property (nonatomic, strong) NSDate *finished_at;
@property (nonatomic, strong) NSDate *duration;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;
@property (nonatomic, strong) CategoryQcm *category;

@end
