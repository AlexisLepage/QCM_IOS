//
//  User.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group.h"

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;
@property (nonatomic, strong) Group *group;

@end
