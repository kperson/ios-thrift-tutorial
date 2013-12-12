//
//  RegisterTokenService.m
//  Chat
//
//  Created by Kelton Person on 12/10/13.
//
//

#import "RegisterTokenService.h"
#import "ChatClientFactory.h"

@interface RegisterTokenService ()

@property (copy) NSString *authToken;
@property (copy) NSString *pushToken;
@property (nonatomic, strong) NSOperationQueue *asyncQueue;

@end

@implementation RegisterTokenService

-(id)initWithPushToken:(NSString *)pushToken authToken:(NSString *)authToken {
    self = [super init];
    if(self){
        self.authToken = authToken;
        self.pushToken = pushToken;
    }
    return self;
}

-(void)execute {
    ChatAPIClient *client = [[ChatClientFactory sharedInstance] client];
    self.asyncQueue = [[NSOperationQueue alloc] init];
    [self.asyncQueue setMaxConcurrentOperationCount:3];
    [self.asyncQueue addOperationWithBlock:^{
        [client registeriOSToken:self.pushToken :self.authToken];
    }];
}

@end
