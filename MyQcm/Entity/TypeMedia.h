//
//  TypeMedia.h
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeMedia : NSObject

@property (nonatomic) int idServer;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *medias;

@end
