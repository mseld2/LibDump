//
//  VersionMinCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef VersionMinCommand_h
#define VersionMinCommand_h

#import "LoadCommand.h"
#import "Version.h"

@interface VersionMinCommand : LoadCommand

@property Version *version;
@property Version *sdk;

- (instancetype) init;

- (NSString*) description;

@end
#endif /* VersionMinCommand_h */
