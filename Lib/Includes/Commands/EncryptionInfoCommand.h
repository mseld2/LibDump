//
//  EncryptionInfoCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef EncryptionInfoCommand_h
#define EncryptionInfoCommand_h

#import "LoadCommand.h"

@interface EncryptionInfoCommand : LoadCommand

@property NSUInteger fileOffset;
@property NSUInteger dataSize;
@property NSUInteger cryptId;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end
#endif /* EncryptionInfoCommand_h */
