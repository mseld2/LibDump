//
//  BuildVersionCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef BuildVersionCommand_h
#define BuildVersionCommand_h

#import "LoadCommand.h"
#import "Version.h"

@interface BuildVersionCommand : LoadCommand

@property NSString *platform;
@property Version *minOs;
@property Version *sdk;
@property NSMutableArray *tools;

- (instancetype) initWithPlatform: (NSUInteger) plaformCode;

- (NSString*) description;

@end

#endif /* BuildVersionCommand_h */
