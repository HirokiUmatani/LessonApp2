//
//  HttpFercher.m
//  LessonApp
//
//  Created by hirokiumatani on 2015/06/02.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import "HttpFercher.h"

@implementation HttpFercher

static NSString * HTTP_GET      = @"GET";
static NSString * HTTP_POST     = @"POST";
static NSInteger HTTP_TIME_OUT  = 20;

- (void)startFetchingWithUrlString:(NSString *)urlString
                           success:(FetchSuccess)success
                            failed:(FetchFailed)failed
{
    NSMutableURLRequest *request = NSMutableURLRequest.new;
    NSURL *url = [NSURL URLWithString:urlString];
    
    request.URL             = url;
    request.HTTPMethod      = HTTP_GET;
    request.timeoutInterval = HTTP_TIME_OUT;

    UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
    UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         if (error)
             failed(error);
         
         else
             success(data);
     }];
}

- (void)startFetchingWithUrlString:(NSString *)urlString
                         paramData:(NSData *)paramData
                           success:(FetchSuccess)success
                            failed:(FetchFailed)failed
{
    NSMutableURLRequest *request = NSMutableURLRequest.new;
    NSURL *url = [NSURL URLWithString:urlString];
    
    request.URL             = url;
    request.HTTPMethod      = HTTP_POST;
    request.timeoutInterval = HTTP_TIME_OUT;
    request.HTTPBody        = paramData;
    
    
    UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
    UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error)
     {
         UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
         if (error)
             failed(error);
         
         else
             success(data);
     }];
}

- (NSData *)setStringParameter:(NSString *)paramString, ...NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *contentLists = @[].mutableCopy;
    va_list args;
    va_start(args, paramString);
    for (NSString *arg = paramString;
         arg != nil;
         arg = va_arg(args, NSString*))
        [contentLists addObject:arg];
    
    va_end(args);
    
    NSMutableString *newContentString = [NSMutableString string];
    [newContentString appendString:@"@\""];
    for(NSInteger i = 0; i < contentLists.count; i++)
    {
        [newContentString appendString:contentLists[i]];
        if (i == contentLists.count - 1)
            break;
        
        if (i % 2 == 0)
            [newContentString appendString:@"="];
        
        else
            [newContentString appendString:@"&"];
    }
    [newContentString appendString:@"\""];
    NSData *result = [newContentString dataUsingEncoding:NSUTF8StringEncoding];
    return result;
}
@end
