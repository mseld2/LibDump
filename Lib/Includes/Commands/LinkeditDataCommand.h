//
//  LinkeditDataCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef LinkeditDataCommand_h
#define LinkeditDataCommand_h

#import "LoadCommand.h"

@interface LinkeditDataCommand : LoadCommand

@property NSUInteger fileOffset;
@property NSUInteger dataSize;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end

#endif /* LinkeditDataCommand_h */
