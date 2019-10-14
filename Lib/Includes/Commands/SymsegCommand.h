//
//  SymsegCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef SymsegCommand_h
#define SymsegCommand_h

#import "LoadCommand.h"

@interface SymsegCommand : LoadCommand

@property NSUInteger symbolSegmentOffset;
@property NSUInteger sizeOfSymbolSegment;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end

#endif /* SymsegCommand_h */
