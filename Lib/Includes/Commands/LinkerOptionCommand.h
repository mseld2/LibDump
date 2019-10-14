//
//  LinkerOptionCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef LinkerOptionCommand_h
#define LinkerOptionCommand_h

#import "LoadCommand.h"

@interface LinkerOptionCommand : LoadCommand

@property NSUInteger numberOfStrings;

- (instancetype) init;

- (NSString*) description;

@end

#endif /* LinkerOptionCommand_h */
