//
//  SourceVersionCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef SourceVersionCommand_h
#define SourceVersionCommand_h

#import "LoadCommand.h"

@interface SourceVersionCommand : LoadCommand

@property NSUInteger version;

- (instancetype) init;

- (NSString*) description;

@end
#endif /* SourceVersionCommand_h */
