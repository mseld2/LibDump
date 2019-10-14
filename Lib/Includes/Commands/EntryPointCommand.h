//
//  EntryPointCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef EntryPointCommand_h
#define EntryPointCommand_h

#import "LoadCommand.h"

@interface EntryPointCommand : LoadCommand

@property NSUInteger entryOffset;
@property NSUInteger stackSize;

- (instancetype) init;

- (NSString*) description;

@end
#endif /* EntryPointCommand_h */
