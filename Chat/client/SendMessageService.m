//
//  SendMessageService.m
//  Chat
//
//  Created by Kelton Person on 12/11/13.
//
//

#import "SendMessageService.h"
#import "ChatClientFactory.h"

@interface SendMessageService ()

@property (copy) NSString *message;
@property (copy) NSString *username;
@property (copy) NSString *authToken;
@property (strong, nonatomic) ChatAPIClient *client;
@property (nonatomic, strong) NSOperationQueue *asyncQueue;

@end

@implementation SendMessageService


-(id)initWithMessage:(NSString *)message username:(NSString *)username authToken:(NSString *)authToken {
    self = [super init];
    if(self){
        self.authToken = authToken;
        self.message = message;
        self.username = username;
    }
    return self;
}

-(void)execute {
    self.client = [[ChatClientFactory sharedInstance] client];
    self.asyncQueue = [self fetchAsyncQueue];
    [self.asyncQueue addOperationWithBlock:^(void) {
        [self.client sendMessage:self.message :self.username :self.authToken];
    }];
}
@end
