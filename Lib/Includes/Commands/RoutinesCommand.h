//
//  RoutinesCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef RoutinesCommand_h
#define RoutinesCommand_h

#import "LoadCommand.h"

@interface RoutinesCommand : LoadCommand

@property NSUInteger initAddress;
@property NSUInteger initIndex;
@property NSUInteger reserved1;
@property NSUInteger reserved2;
@property NSUInteger reserved3;
@property NSUInteger reserved4;
@property NSUInteger reserved5;
@property NSUInteger reserved6;

- (instancetype) init;

- (NSString*) description;

@end
#endif /* RoutinesCommand_h */
