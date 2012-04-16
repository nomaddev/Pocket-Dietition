//
//  USDADatabaseParser.m
//  USDADataParser
//
//  Created by Rafael Santiago, Jr. on 1/26/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//
//  Based off of Dave Delong's answer on StackOverflow
//  http://stackoverflow.com/questions/3707427/how-to-read-data-from-nsfilehandle-line-by-line

#import "USDATableParser.h"
#import "USDATableRow.h"

//Category for NSData to allow some of this magic to happen
@interface NSData (DDAdditions)

- (NSRange) rangeOfData_dd:(NSData *)dataToFind;

@end

@implementation NSData (DDAdditions)

int encoding = NSISOLatin1StringEncoding;

- (NSRange) rangeOfData_dd:(NSData *)dataToFind {

    
    const void * bytes = [self bytes];
    NSUInteger length = [self length];
    
    const void * searchBytes = [dataToFind bytes];
    NSUInteger searchLength = [dataToFind length];
    NSUInteger searchIndex = 0;
    
    NSRange foundRange = {NSNotFound, searchLength};
    for (NSUInteger index = 0; index < length; index++) {
        if (((char *)bytes)[index] == ((char *)searchBytes)[searchIndex]) {
            //the current character matches
            if (foundRange.location == NSNotFound) {
                foundRange.location = index;
            }
            searchIndex++;
            if (searchIndex >= searchLength) { return foundRange; }
        } else {
            searchIndex = 0;
            foundRange.location = NSNotFound;
        }
    }
    return foundRange;
}

@end

/* Convert some of the read methods into private ones;
 * We don't want to expose readLine and readTrimmedLine
 * though we use those internally
 */
@interface USDATableParser()

- (NSString *) readLine;
- (NSString *) readTrimmedLine;

#if NS_BLOCKS_AVAILABLE
- (void) enumerateLinesUsingBlock:(void(^)(NSString*, BOOL *))block;
#endif

@end
@implementation USDATableParser
@synthesize lineDelimiter, chunkSize;

- (id) initWithFilePath:(NSString *)aPath
{
    if (self = [super init]) {
        fileHandle = [NSFileHandle fileHandleForReadingAtPath:aPath];
        if (fileHandle == nil) {
            return nil;
        }
        
        lineDelimiter = [[NSString alloc] initWithString:@"\n"];
        filePath = aPath;
        currentOffset = 0ULL;
        chunkSize = 10;
        [fileHandle seekToEndOfFile];
        totalFileLength = [fileHandle offsetInFile];
        
        //we don't need to seek back, since readLine will do that.
    }
    return self;
}

- (void) dealloc {
    [fileHandle closeFile];
    currentOffset = 0ULL;
}

// Retrieves one row from the database
- (USDATableRow *) readDatabaseRow
{
    NSString *line = [self readTrimmedLine];
    if(!line)
    {
        //NSLog(@"~~~~~~nil row");
        return nil ; 
    }
    
    USDATableRow *databaseRow = [[USDATableRow alloc] init];
    
    [databaseRow loadFromLine:line];
    return databaseRow;
}

- (NSString *) readLine 
{
    //NSLog(@"readLine START");
    if (currentOffset >= totalFileLength) 
    {
        //NSLog(@"offset>totFileLen");
        return nil; 
    }
    
    NSData * newLineData = [lineDelimiter dataUsingEncoding:encoding];
    [fileHandle seekToFileOffset:currentOffset];
    NSMutableData * currentData = [[NSMutableData alloc] init];
    BOOL shouldReadMore = YES;
    
    @autoreleasepool {
        while (shouldReadMore) {
            if (currentOffset >= totalFileLength) 
            { 
                 //NSLog(@"offset>totFileLen, break");
                break; 
            }
            NSData * chunk = [fileHandle readDataOfLength:chunkSize];
            //NSLog(@"chuunk: %@", [[NSString alloc] initWithData:chunk encoding:encoding]);
            NSRange newLineRange = [chunk rangeOfData_dd:newLineData];
            if (newLineRange.location != NSNotFound) 
            {
                //NSLog(@"found line delimiter");
                //include the length so we can include the delimiter in the string
                chunk = [chunk subdataWithRange:NSMakeRange(0, newLineRange.location+[newLineData length])];
                shouldReadMore = NO;
            }
            
            [currentData appendData:chunk];
            currentOffset += [chunk length];
        }
    }
    
    NSString * line = [[NSString alloc] initWithData:currentData encoding:encoding];
        //NSLog(@"readLine END: %@", line);
    return line;
}

- (NSString *) readTrimmedLine {
    return [[self readLine] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#if NS_BLOCKS_AVAILABLE
- (void) enumerateLinesUsingBlock:(void(^)(NSString*, BOOL*))block {
    NSString * line = nil;
    BOOL stop = NO;
    while (stop == NO && (line = [self readLine])) {
        block(line, &stop);
    }
}
#endif

@end