//
//  DirectoryFileManager.m
//  LessonApp
//
//  Created by hirokiumatani on 2015/07/20.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import "DirectoryFileManager.h"

@implementation DirectoryFileManager
+ (NSArray *)getDirectory:(NSString *)dirPath
{
    if ([self checkDirectory:dirPath])
    {
        return [[NSFileManager new] contentsOfDirectoryAtPath:dirPath error:nil];
    }
    return @[].copy;
}
+ (NSData *)getFileWithDirPath:(NSString *)dirPath
                  filePath:(NSString *)filePath
{
    if ([self checkFileWithDirPath:dirPath filePath:filePath])
    {
        return [[NSFileManager new] contentsAtPath:[NSString stringWithFormat:
                                                    @"%@/%@/%@",
                                                    NSHomeDirectory(),
                                                    dirPath,
                                                    filePath]];
    }
    return @[].copy;
}
#pragma mark - check
+ (BOOL)checkFileWithDirPath:(NSString *)dirPath
                    filePath:(NSString *)filePath
{
    
    return [[NSFileManager new] fileExistsAtPath:[NSString stringWithFormat:
                                                  @"%@/%@/%@",
                                                  NSHomeDirectory(),
                                                  dirPath,
                                                  filePath]];
}
+ (BOOL)checkDirectory:(NSString *)dirPath
{
    
    return [[NSFileManager new] fileExistsAtPath:[NSString stringWithFormat:
                                                  @"%@/%@",
                                                  NSHomeDirectory(),
                                                  dirPath]];
}
#pragma mark - create
+ (void)createDirectory:(NSString *)dirPath
              permisson:(NSNumber *)permission
{
    if ([self checkDirectory:dirPath])
        return;
    
    [[NSFileManager new] createDirectoryAtPath:[NSString stringWithFormat:
                                                @"%@/%@",
                                                NSHomeDirectory(),
                                                dirPath]
                   withIntermediateDirectories:YES
                                    attributes:@{NSFilePosixPermissions: permission}
                                         error:nil];
    
    
}

+ (void)createFile:(NSData   *)fileData
           dirPath:(NSString *)dirPath
          filePath:(NSString *)filePath
         permisson:(NSNumber *)permission
{
    
    if ([self checkFileWithDirPath:dirPath filePath:filePath])
        return;
    
    [[NSFileManager new] createFileAtPath:[NSString stringWithFormat:
                                           @"%@/%@/%@",
                                           NSHomeDirectory(),
                                           dirPath,
                                           filePath]
                                 contents:fileData
                               attributes:@{NSFilePosixPermissions: permission}];
}

+ (void)deleteDirectory:(NSString *)dirPath
{
    [[NSFileManager new] removeItemAtPath:[NSString stringWithFormat:
                                           @"%@/%@",
                                           NSHomeDirectory(),
                                           dirPath]
                                    error:nil];
}
+ (void)deleteFileWithDirPath:(NSString *)dirPath
                     filePath:(NSString *)filePath
{
    [[NSFileManager new] removeItemAtPath:[NSString stringWithFormat:
                                           @"%@/%@/%@",
                                           NSHomeDirectory(),
                                           dirPath,
                                           filePath]
                                    error:nil];
}
@end
