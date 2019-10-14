//
//  UuidCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef UuidCommand_h
#define UuidCommand_h

#import "LoadCommand.h"

@interface UuidCommand : LoadCommand

@property NSData *uuid;

- (instancetype) init;

- (NSString*) description;

@end
#endif /* UuidCommand_h */
