//
//  BasicCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef BasicCommand_h
#define BasicCommand_h

#import <Foundation/Foundation.h>

#import "LoadCommand.h"

@interface BasicCommand : LoadCommand

@property NSUInteger nameOffset;

- (instancetype) initWithName: (NSString*) commandName;

- (NSString*) description;

@end

#endif /* BasicCommand_h */
