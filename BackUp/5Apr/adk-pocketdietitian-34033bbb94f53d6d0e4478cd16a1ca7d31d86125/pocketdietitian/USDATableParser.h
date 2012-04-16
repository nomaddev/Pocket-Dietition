//
//  USDADatabaseParser.h
//  USDADataParser
//
//  Created by Rafael Santiago, Jr. on 1/26/12.
//  Copyright (c) 2012 New Frontier Nomads. All rights reserved.
//
//  Based off of Dave Delong's answer on StackOverflow
//  http://stackoverflow.com/questions/3707427/how-to-read-data-from-nsfilehandle-line-by-line
//  
//  Parses a USDA database table file.

#import <Foundation/Foundation.h>
@class USDATableRow;

@interface USDATableParser : NSObject{
    NSString * filePath;
    
    NSFileHandle * fileHandle;
    unsigned long long currentOffset;
    unsigned long long totalFileLength;
    
    NSString * lineDelimiter;
    NSUInteger chunkSize;
    
}


@property (nonatomic, copy) NSString * lineDelimiter;
@property (nonatomic) NSUInteger chunkSize;

- (id) initWithFilePath:(NSString *)aPath;

- (USDATableRow *) readDatabaseRow;


@end
