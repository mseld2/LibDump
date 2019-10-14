//
//  DyldInfoCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef DyldInfoCommand_h
#define DyldInfoCommand_h

#import "LoadCommand.h"

@interface DyldInfoCommand : LoadCommand

@property NSUInteger rebaseInfoOffset;
@property NSUInteger sizeOfRebaseInfo;

@property NSUInteger bindingInfoOffset;
@property NSUInteger sizeOfBindingInfo;

@property NSUInteger weakBindingInfoOffset;
@property NSUInteger sizeOfWeakBindInfo;

@property NSUInteger lazyBindingInfoOffset;
@property NSUInteger sizeOfLazyBindingInfo;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end

#endif /* DyldInfoCommand_h */
