//
//  FvmfileCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef FvmfileCommand_h
#define FvmfileCommand_h

#import "BasicCommand.h"

@interface FvmfileCommand : BasicCommand

@property NSUInteger headerAddress;

- (instancetype) init;

- (NSString*) description;

@end

#endif /* FvmfileCommand_h */
