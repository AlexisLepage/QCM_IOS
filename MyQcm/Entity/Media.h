//
//  Media.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "TypeMedia.h"

@interface Media : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;
@property (nonatomic, strong) Question *question;
@property (nonatomic, strong) TypeMedia *type_media;

@end
