//
//  LoadCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef LoadCommand_h
#define LoadCommand_h

#import "MachOBase.h"

@interface LoadCommand : MachOBase

@property NSString *commandType;
@property NSUInteger command;
@property NSUInteger commandSize;

- (instancetype) initWithName: (NSString*) commandName;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end

#endif /* LoadCommand_h */
