//
//  BaseService.m
//  Chat
//
//  Created by Kelton Person on 12/10/13.
//
//

#import "BaseService.h"

@implementation BaseService


-(NSOperationQueue *)fetchAsyncQueue {
    NSOperationQueue *asyncQueue = [[NSOperationQueue alloc] init];
    [asyncQueue setMaxConcurrentOperationCount:1] ;
    return asyncQueue;
}

@end
