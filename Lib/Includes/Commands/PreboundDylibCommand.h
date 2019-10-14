//
//  PreboundDylibCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef PreboundDylibCommand_h
#define PreboundDylibCommand_h

#import <Foundation/Foundation.h>

#import "BasicCommand.h"

@interface PreboundDylibCommand : BasicCommand

@property NSUInteger numberOfModules;
@property NSUInteger linkedModules;

- (instancetype) init;

- (NSString*) description;

@end

#endif /* PreboundDylibCommand_h */
