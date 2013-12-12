//
//  MessageManager.m
//  Chat
//
//  Created by Kelton Person on 12/11/13.
//
//

#import "MessageManager.h"

@implementation MessageManager


+ (MessageManager *)sharedInstance
{
    //  Static local predicate must be initialized to 0
    static MessageManager *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MessageManager alloc] init];
    });
    return sharedInstance;
}

-(void)messageReceived:(NSString *)message {
    if(self.handler){
        [self.handler onMessageReceived:message];
    }
}


@end
