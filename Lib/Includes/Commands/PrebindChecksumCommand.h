//
//  PrebindChecksumCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef PrebindChecksumCommand_h
#define PrebindChecksumCommand_h

#import "LoadCommand.h"

@interface PrebindChecksumCommand : LoadCommand

@property NSUInteger checksum;

- (instancetype) init;

- (NSString*) description;

@end

#endif /* PrebindChecksumCommand_h */
