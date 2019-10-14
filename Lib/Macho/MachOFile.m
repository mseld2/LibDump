//
//  MachOFile.m
//  LibDump
//
//  Created by Melissa Weiss on 10/12/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <mach-o/loader.h>
#import <mach-o/dyld.h>
#import <mach-o/nlist.h>
#import <mach-o/stab.h>

#import "MachOFile.h"
#import "SegmentCommand.h"
#import "DylibCommand.h"
#import "Section.h"
#import "BasicCommand.h"
#import "PreboundDylibCommand.h"
#import "RoutinesCommand.h"
#import "SymtabCommand.h"
#import "DysymtabCommand.h"
#import "TwoLevelHintsCommand.h"
#import "PrebindChecksumCommand.h"
#import "UuidCommand.h"
#import "LinkeditDataCommand.h"
#import "EncryptionInfoCommand.h"
#import "Version.h"
#import "VersionMinCommand.h"
#import "BuildVersionCommand.h"
#import "BuildToolVersion.h"
#import "DyldInfoCommand.h"
#import "LinkerOptionCommand.h"
#import "SymsegCommand.h"
#import "FvmfileCommand.h"
#import "EntryPointCommand.h"
#import "SourceVersionCommand.h"
#import "NoteCommand.h"

@implementation MachOFile

struct mach_header* header = NULL;
unsigned char *pCurrent = NULL;

- (instancetype) initWithLibName: (NSString*) libName {
    self = [super init];
    if(self) {
        _libraryName = libName;
        _sections = [NSMutableArray array];
        _commands = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype) initWithLibPath: (NSString*) libPath {
    self = [super init];
    if(self) {
        _libraryName = libPath;
        _libraryName = [libPath lastPathComponent];
        _sections = [NSMutableArray array];
        _commands = [NSMutableArray array];
    }
    
    return self;
}

- (bool) libraryExists {
    uint32_t count = _dyld_image_count();
    for(uint32_t c = 0; c < count; ++c) {
        const char *imageName = _dyld_get_image_name(c);
        printf("%s", imageName);
        _libraryPath = [NSString stringWithCString: imageName encoding: NSUTF8StringEncoding];
        if([_libraryPath containsString: _libraryName]) {
            header = (struct mach_header*)_dyld_get_image_header(c);
            return true;
        }
    }
    
    return false;
}

- (NSArray*) getLoadedLibraries {
    NSMutableArray *loadedLibraries = [NSMutableArray array];
    uint32_t count = _dyld_image_count();
    for(uint32_t c = 0; c < count; ++c) {
        const char *name = _dyld_get_image_name(c);
        printf("%s", name); // TODO: remove
        NSString *str = [NSString stringWithCString: name encoding: NSUTF8StringEncoding];
        [loadedLibraries addObject: str];
    }
    
    return loadedLibraries;
}

- (void) copyLibrary {
 
    unsigned char bytes[_size];
    memcpy(bytes, header, _size);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *copyPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", _libraryName]];
    
    NSData *data = [NSData dataWithBytes: bytes length: _size];
    
    [[NSFileManager defaultManager] createFileAtPath: copyPath contents: data attributes: nil];
}

- (void) parse {
    if(![self libraryExists]) {
        return;
    }
    
    pCurrent = (unsigned char*)header;
    bool isValid = true;
    _size = 0;
    _machHeader = [self readHeader];
    while(isValid) {
        if([self isSection: pCurrent]) {
            Section *section = [self readSection];
            [_sections addObject: section];
        } else if([self isCommand: pCurrent]) {
            struct load_command *command = (struct load_command*)pCurrent;
            [self addLoadCommand: command];
        } else {
            isValid = false;
        }
    }
}

- (void) addLoadCommand: (struct load_command*) loadCommand {
    switch(loadCommand->cmd) {
        case LC_SEGMENT_64:
        {
            SegmentCommand *command = [self readSegmentCommand];
            [_commands addObject: command];
        }
            break;
        case LC_ID_DYLIB:
        case LC_LOAD_DYLIB:
        case LC_LOAD_WEAK_DYLIB:
        case LC_REEXPORT_DYLIB:
        {
            DylibCommand *command = [self readDylibCommand];
            [_commands addObject: command];
        }
            break;
        case LC_SUB_LIBRARY:
        case LC_SUB_UMBRELLA:
        case LC_SUB_FRAMEWORK:
        case LC_SUB_CLIENT:
        case LC_ID_DYLINKER:
        case LC_LOAD_DYLINKER:
        case LC_DYLD_ENVIRONMENT:
        case LC_RPATH:
        {
            BasicCommand *command = [self readBasicCommand: loadCommand];
            [_commands addObject: command];
        }
            break;
        case LC_PREBOUND_DYLIB:
        {
            PreboundDylibCommand *command = [self readPreboundDylibCommand];
            [_commands addObject: command];
        }
            break;
        case LC_THREAD:
        case LC_UNIXTHREAD:
        case LC_IDENT:
        {
            LoadCommand *command = [self readLoadCommand: loadCommand];
            [_commands addObject: command];
        }
            break;
        case LC_ROUTINES_64:
        {
            RoutinesCommand *command = [self readRoutinesCommand];
            [_commands addObject: command];
        }
            break;
        case LC_SYMTAB:
        {
            SymtabCommand *command = [self readSymtabCommand];
            [_commands addObject: command];
        }
            break;
        case LC_DYSYMTAB:
        {
            DysymtabCommand *command = [self readDynsymtabCommand];
            [_commands addObject: command];
        }
            break;
        case LC_TWOLEVEL_HINTS:
        {
            TwoLevelHintsCommand *command = [self readTwoLevelHintsCommand];
            [_commands addObject: command];
        }
            break;
        case LC_PREBIND_CKSUM:
        {
            PrebindChecksumCommand *command = [self readPrebindChecksumCommand];
            [_commands addObject: command];
        }
            break;
        case LC_UUID:
        {
            UuidCommand *command = [self readUuidCommand];
            [_commands addObject: command];
        }
            break;
        case LC_CODE_SIGNATURE:
        case LC_SEGMENT_SPLIT_INFO:
        case LC_FUNCTION_STARTS:
        case LC_DATA_IN_CODE:
        case LC_DYLIB_CODE_SIGN_DRS:
        case LC_LINKER_OPTIMIZATION_HINT:
        case LC_DYLD_EXPORTS_TRIE:
        case LC_DYLD_CHAINED_FIXUPS:
        {
            LinkeditDataCommand *command = [self readLinkeditDataCommand];
            [_commands addObject: command];
        }
            break;
        case LC_ENCRYPTION_INFO_64:
        {
            EncryptionInfoCommand *command = [self readEncryptionInfoCommand];
            [_commands addObject: command];
        }
            break;
        case LC_VERSION_MIN_MACOSX:
        case LC_VERSION_MIN_IPHONEOS:
        case LC_VERSION_MIN_TVOS:
        case LC_VERSION_MIN_WATCHOS:
        {
            VersionMinCommand *command = [self readVersionMinCommand];
            [_commands addObject: command];
        }
            break;
        case LC_BUILD_VERSION:
        {
            BuildVersionCommand *command = [self readBuildVersionCommand];
            [_commands addObject: command];
        }
            break;
        case LC_DYLD_INFO:
        {
            DyldInfoCommand *command = [self readDyldInfoCommand];
            [_commands addObject: command];
        }
            break;
        case LC_LINKER_OPTION:
        {
            LinkerOptionCommand *command = [self readLinkerOptionCommand];
            [_commands addObject: command];
        }
            break;
        case LC_SYMSEG:
        {
            SymsegCommand *command = [self readSymsegCommand];
            [_commands addObject: command];
        }
            break;
        case LC_FVMFILE:
        {
            FvmfileCommand *command = [self readFvmfileCommand];
            [_commands addObject: command];
        }
            break;
        case LC_MAIN:
        {
            EntryPointCommand *command = [self readEntryPointCommand];
            [_commands addObject: command];
        }
            break;
        case LC_SOURCE_VERSION:
        {
            SourceVersionCommand *command = [self readSourceVersionCommand];
            [_commands addObject: command];
        }
            break;
        case LC_NOTE:
        {
            NoteCommand *command = [self readNoteCommand];
            [_commands addObject: command];
        }
            break;
    }
}

- (bool) isSection: (unsigned char*) ptr {
    struct section_64 *section = (struct section_64*)ptr;
    
    return section->sectname[0] == '_';
}

- (bool) isCommand: (unsigned char*) ptr {
    struct load_command *command = (struct load_command*)ptr;
    
    return [self isValidLoadCommand: command->cmd];
}
    
- (bool) isValidLoadCommand: (uint32_t) cmd {
    return (cmd > LC_SEGMENT && cmd <= LC_PREBIND_CKSUM) || cmd == LC_LOAD_WEAK_DYLIB ||
            cmd == LC_SEGMENT_64 || cmd == LC_ROUTINES_64 || cmd == LC_UUID ||
            cmd == LC_RPATH || cmd == LC_CODE_SIGNATURE || cmd == LC_SEGMENT_SPLIT_INFO ||
            cmd == LC_REEXPORT_DYLIB || (cmd >= LC_LAZY_LOAD_DYLIB && cmd <=LC_DYLD_INFO) ||
            cmd == LC_DYLD_INFO_ONLY || cmd == LC_LOAD_UPWARD_DYLIB || (cmd >= LC_VERSION_MIN_MACOSX && cmd <= LC_DYLD_ENVIRONMENT) ||
            cmd == LC_MAIN || (cmd >= LC_DATA_IN_CODE && cmd <= LC_BUILD_VERSION) || cmd == LC_DYLD_EXPORTS_TRIE || cmd == LC_DYLD_CHAINED_FIXUPS;
        
}

- (MachHeader*) readHeader {
    MachHeader *obj = [MachHeader alloc];
    
    obj.magic = header->magic;
    obj.cpuType = header->cputype;
    obj.cpuSubtype = header->cpusubtype;
    obj.fileType = header->filetype;
    obj.numberOfLoadCommands = header->ncmds;
    obj.totalSizeOfLoadCommands = header->sizeofcmds;
    obj.flags = header->flags;
    
    pCurrent = (unsigned char*)(header + sizeof(struct mach_header_64));
    _size += (sizeof(struct mach_header_64) + obj.totalSizeOfLoadCommands);
    
    return obj;
}

- (SegmentCommand*) readSegmentCommand {
    SegmentCommand *obj = [SegmentCommand alloc];
    struct segment_command_64 *command = (struct segment_command_64*)pCurrent;
    obj.command = command->cmd;
    obj.command = command->cmdsize;
    obj.name = [NSString stringWithCString: command->segname encoding: NSUTF8StringEncoding];
    obj.vmAddress = command->vmaddr;
    obj.vmSize = command->vmsize;
    obj.fileOffset = command->fileoff;
    obj.maxVmProtection = command->maxprot;
    obj.initVmProtection = command->initprot;
    obj.numberOfSections = command->nsects;
    obj.flags = command->flags;
    
    pCurrent += command->cmdsize;
    
    for(uint32_t nsect = 0; nsect < command->nsects; ++nsect) {
        Section *section = [self readSection];
        [obj.sections addObject: section];
    }
    
    return obj;
}

- (Section*) readSection {
    Section *obj = [Section alloc];
    struct section_64 *section = (struct section_64*)pCurrent;
    obj.name = [NSString stringWithCString: section->sectname encoding: NSUTF8StringEncoding];
    obj.segment = [NSString stringWithCString: section->segname encoding: NSUTF8StringEncoding];
    obj.address = section->addr;
    obj.size = section->size;
    obj.fileOffset = section->offset;
    obj.sectionAlignment = section->align;
    obj.relocationFileOffset = section->reloff;
    obj.numberOfRelocationEntries = section->nreloc;
    obj.flags = section->flags;
    obj.reserved1 = section->reserved1;
    obj.reserved2 = section->reserved2;
    obj.reserved3 = section->reserved3;
    
    pCurrent += sizeof(struct section_64);
    _size += sizeof(struct section_64);
    
    return obj;
}

- (DylibCommand*) readDylibCommand {
    DylibCommand *obj = [DylibCommand alloc];
    struct dylib_command *command = (struct dylib_command*)pCurrent;
    obj.command = command->cmd;
    obj.command = command->cmdsize;
    obj.offsetToPathName = command->dylib.name.offset;
    obj.buildTime = command->dylib.timestamp;
    obj.currentVersion = command->dylib.current_version;
    obj.compatibilityVersion = command->dylib.compatibility_version;
    
    pCurrent += command->cmdsize;
   _size += [obj getDataSize];
    
    return obj;
}

- (BasicCommand*) readBasicCommand: (struct load_command*) loadCommand {
    NSString *commandType;
    switch(loadCommand->cmd) {
        case LC_SUB_FRAMEWORK:
        {
            commandType = @"SubFrameworkCommand";
        }
            break;
        case LC_SUB_CLIENT:
        {
            commandType = @"SubClientCommand";
        }
            break;
        case LC_SUB_UMBRELLA:
        {
            commandType = @"SubUmbrellaCommand";
        }
            break;
        case LC_SUB_LIBRARY:
        {
            commandType = @"SubLibraryCommand";
        }
            break;
        case LC_ID_DYLINKER:
        case LC_LOAD_DYLINKER:
        case LC_DYLD_ENVIRONMENT:
        {
            commandType = @"DylinkerCommand";
        }
            break;
        case LC_RPATH:
        {
            commandType = @"RpathCommand";
        }
            break;
    }
    // they're all the same layout, so just pick one
    struct sub_framework_command *command = (struct sub_framework_command*)loadCommand;
    BasicCommand *obj = [[BasicCommand alloc] initWithName: commandType];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.nameOffset = command->umbrella.offset;
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (PreboundDylibCommand*) readPreboundDylibCommand {
    struct prebound_dylib_command *command = (struct prebound_dylib_command*)pCurrent;
    PreboundDylibCommand *obj = [PreboundDylibCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.numberOfModules = command->nmodules;
    obj.linkedModules = command->name.offset;
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (LoadCommand*) readLoadCommand: (struct load_command*) loadCommand {
    NSString *commandType;
    switch(loadCommand->cmd)
    {
        case LC_IDENT:
            commandType = @"IdentCommand";
            break;
        case LC_THREAD:
        case LC_UNIXTHREAD:
            commandType = @"ThreadCommand";
            break;
    }
    LoadCommand *obj = [[LoadCommand alloc] initWithName: commandType];
    obj.command = loadCommand->cmd;
    obj.commandSize = loadCommand->cmdsize;
        
    pCurrent += loadCommand->cmdsize;
    _size += loadCommand->cmdsize;
        
    return obj;
}

- (RoutinesCommand*) readRoutinesCommand {
    struct routines_command_64 *command = (struct routines_command_64*)pCurrent;
    RoutinesCommand *obj = [RoutinesCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.initAddress = command->init_address;
    obj.initIndex = command->init_module;
    obj.reserved1 = command->reserved1;
    obj.reserved2 = command->reserved2;
    obj.reserved3 = command->reserved3;
    obj.reserved4 = command->reserved4;
    obj.reserved5 = command->reserved5;
    obj.reserved6 = command->reserved6;
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (SymtabCommand*) readSymtabCommand {
    struct symtab_command *command = (struct symtab_command*)pCurrent;
    SymtabCommand *obj = [SymtabCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.symbolTableOffset = command->symoff;
    obj.numberOfSymbols = command->nsyms;
    obj.stringTableOffset = command->stroff;
    obj.sizeOfStringTable = command->strsize;
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (DysymtabCommand*) readDynsymtabCommand {
    struct dysymtab_command *command = (struct dysymtab_command*)pCurrent;
    DysymtabCommand *obj = [DysymtabCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.localSymbolIndex = command->ilocalsym;
    obj.numberOfLocalSymbols = command->nlocalsym;
    obj.externSymbolIndex = command->iextdefsym;
    obj.numberOfExternSymbols = command->nextdefsym;
    obj.moduleTableOffset = command->modtaboff;
    obj.numberOfModuleTableEntries = command->nmodtab;
    obj.refSymbolTableOffset = command->extreloff;
    obj.numberOfRefSymbolTableEntries = command->nextrefsyms;
    obj.indirectSymbolOffset = command->indirectsymoff;
    obj.numberOfIndirectSymbols = command->nindirectsyms;
    obj.externRelocOffset = command->extreloff;
    obj.numberOfRefSymbolTableEntries = command->nlocrel;
    obj.localRelocOffset = command->locreloff;
    obj.numberOfLocalRelocEntries = command->nlocrel;
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (TwoLevelHintsCommand*) readTwoLevelHintsCommand {
    struct twolevel_hints_command *command = (struct twolevel_hints_command*)pCurrent;
    TwoLevelHintsCommand *obj = [TwoLevelHintsCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.hintsTableOffset = command->offset;
    obj.numberOfHints = command->nhints;
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (PrebindChecksumCommand*) readPrebindChecksumCommand {
    struct prebind_cksum_command *command = (struct prebind_cksum_command*)pCurrent;
    PrebindChecksumCommand *obj = [PrebindChecksumCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.checksum = command->cksum;
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (UuidCommand*) readUuidCommand {
    struct uuid_command *command = (struct uuid_command*)pCurrent;
    UuidCommand *obj = [UuidCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.uuid = [NSData dataWithBytes: command->uuid length: 16];
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (LinkeditDataCommand*) readLinkeditDataCommand {
    struct linkedit_data_command *command = (struct linkedit_data_command*)pCurrent;
    LinkeditDataCommand *obj = [LinkeditDataCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.fileOffset = command->dataoff;
    obj.dataSize = command->datasize;
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (EncryptionInfoCommand*) readEncryptionInfoCommand {
    struct encryption_info_command_64 *command = (struct encryption_info_command_64*)pCurrent;
    EncryptionInfoCommand *obj = [EncryptionInfoCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.fileOffset = command->cryptoff;
    obj.dataSize = command->cryptsize;
    obj.cryptId = command->cryptid;

    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (VersionMinCommand*) readVersionMinCommand {
    struct version_min_command *command = (struct version_min_command*)pCurrent;
    VersionMinCommand *obj = [VersionMinCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.version = [[Version alloc] initWithNumber: command->version];
    obj.sdk = [[Version alloc] initWithNumber: command->sdk];
    
    pCurrent += command->cmdsize;
    _size += [obj getDataSize];
    
    return obj;
}

- (BuildVersionCommand*) readBuildVersionCommand {
    struct build_version_command *command = (struct build_version_command*)pCurrent;
    BuildVersionCommand *obj = [[BuildVersionCommand alloc] initWithPlatform: command->platform];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.minOs = [[Version alloc] initWithNumber: command->minos];
    obj.sdk = [[Version alloc] initWithNumber: command->sdk];
    
    pCurrent += sizeof(struct build_version_command);
    
    for(uint32_t index = 0; index < command->ntools; ++index) {
        struct build_tool_version *buildTool = (struct build_tool_version*)pCurrent;
        BuildToolVersion *tool = [[BuildToolVersion alloc] initWithTool: buildTool->tool];
        tool.version = buildTool->version;
        [obj.tools addObject: tool];
        
        pCurrent += sizeof(struct build_tool_version);
    }
    
    _size += [obj getDataSize];
    
    return obj;
}

- (DyldInfoCommand*) readDyldInfoCommand {
    struct dyld_info_command *command = (struct dyld_info_command*)pCurrent;
    DyldInfoCommand *obj = [DyldInfoCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.rebaseInfoOffset = command->rebase_off;
    obj.sizeOfRebaseInfo = command->rebase_size;
    obj.bindingInfoOffset = command->bind_off;
    obj.sizeOfBindingInfo = command->bind_size;
    obj.weakBindingInfoOffset = command->weak_bind_off;
    obj.sizeOfWeakBindInfo = command->weak_bind_size;
    obj.lazyBindingInfoOffset = command->export_off;
    obj.sizeOfLazyBindingInfo = command->export_size;
    
    pCurrent += obj.commandSize;
    _size += [obj getDataSize];
    return obj;
    
}

- (LinkerOptionCommand*) readLinkerOptionCommand {
    struct linker_option_command *command = (struct linker_option_command*)pCurrent;
    LinkerOptionCommand *obj = [LinkerOptionCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.numberOfStrings = command->count;
    
    pCurrent += obj.commandSize;
    _size += [obj getDataSize];
    
    return obj;
}

- (SymsegCommand*) readSymsegCommand {
    struct symseg_command *command = (struct symseg_command*)pCurrent;
    SymsegCommand *obj = [SymsegCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.symbolSegmentOffset = command->offset;
    obj.sizeOfSymbolSegment = command->size;
    
    pCurrent += obj.commandSize;
    _size += [obj getDataSize];
    
    return obj;
}

- (FvmfileCommand*) readFvmfileCommand {
    struct fvmfile_command *command = (struct fvmfile_command*)pCurrent;
    FvmfileCommand *obj = [FvmfileCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.nameOffset = command->name.offset;
    obj.headerAddress = command->header_addr;
    
    pCurrent += obj.commandSize;
    _size += [obj getDataSize];
    
    return obj;
}

- (EntryPointCommand*) readEntryPointCommand {
    struct entry_point_command *command = (struct entry_point_command*)pCurrent;
    EntryPointCommand *obj = [EntryPointCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.entryOffset = command->entryoff;
    obj.stackSize = command->stacksize;
    
    pCurrent += obj.commandSize;
    _size += [obj getDataSize];
    
    return obj;
    
}

- (SourceVersionCommand*) readSourceVersionCommand {
    struct source_version_command *command = (struct source_version_command*)pCurrent;
    SourceVersionCommand *obj = [SourceVersionCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.version = command->version;
    
    pCurrent += obj.commandSize;
    _size += [obj getDataSize];
    
    return obj;
}

- (NoteCommand*) readNoteCommand {
    struct note_command *command = (struct note_command*)pCurrent;
    NoteCommand *obj = [NoteCommand alloc];
    obj.command = command->cmd;
    obj.commandSize = command->cmdsize;
    obj.ownerName = [NSString stringWithCString: command->data_owner encoding:NSUTF8StringEncoding];
    obj.fileOffset = command->offset;
    obj.size = command->size;
     
    pCurrent += obj.commandSize;
    _size += [obj getDataSize];
     
    return obj;
}

@end
