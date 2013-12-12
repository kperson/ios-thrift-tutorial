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

@property (strong, nonatomic) NSString *authToken;
@property (strong, nonatomic) NSString *pushToken;
@property (weak, nonatomic) id<RegisterTokenDelegate> delegate;
@property (nonatomic, strong) NSOperationQueue *asyncQueue;
@property (strong, nonatomic) ChatAPIClient *client;

@end

@implementation RegisterTokenService

-(id)initWithPushToken:(NSString *)pushToken authToken:(NSString *)authToken delegate:(id<RegisterTokenDelegate>)delegte {
    self = [super init];
    if(self){
        self.authToken = authToken;
        self.pushToken = pushToken;
        self.delegate = delegte;
    }
    return self;
}

-(void)execute {
    self.client = [[ChatClientFactory sharedInstance] client];
    self.asyncQueue = [self fetchAsyncQueue];
    __weak RegisterTokenService *weakSelf = self;
    [self.asyncQueue addOperationWithBlock:^(void) {
        [weakSelf.client registeriOSToken:weakSelf.pushToken :weakSelf.authToken];
        [self performSelectorOnMainThread:@selector(success) withObject:nil waitUntilDone:NO];
    }];
}

-(void)success {
    if(self.delegate){
        [self.delegate onTokenRegistered];
    }
}

@end
