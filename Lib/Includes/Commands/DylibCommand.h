//
//  DylibCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef DylibCommand_h
#define DylibCommand_h

#import <Foundation/Foundation.h>

#import "LoadCommand.h"

@interface DylibCommand : LoadCommand

@property NSUInteger offsetToPathName;
@property NSUInteger buildTime;
@property NSUInteger currentVersion;
@property NSUInteger compatibilityVersion;

- (instancetype) init;

- (NSString*) description;

@end
#endif /* DylibCommand_h */
