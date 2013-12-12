//
//  GetConversationService.m
//  Chat
//
//  Created by Kelton Person on 12/11/13.
//
//

#import "GetConversationService.h"
#import "ChatClientFactory.h"

@interface GetConversationService ()

@property (nonatomic, strong) NSOperationQueue *asyncQueue;
@property (strong, nonatomic) ChatAPIClient *client;
@property (strong, nonatomic) NSString *authToken;
@property (strong, nonatomic) NSString *friendUsername;
@property (weak, nonatomic) id<GetConversationDelegate> delegate;


@end

@implementation GetConversationService

-(id)initWithFriendName:(NSString *)friend authToken:(NSString *)token delegate:(id<GetConversationDelegate>)delegate {
    self = [super init];
    if(self){
        self.authToken = token;
        self.friendUsername = friend;
        self.delegate = delegate;
    }
    return self;
}

-(void)execute {
    self.client = [[ChatClientFactory sharedInstance] client];
    self.asyncQueue = [self fetchAsyncQueue];
    __weak GetConversationService *weakSelf = self;
    [self.asyncQueue addOperationWithBlock:^(void) {
        NSArray *convo = [weakSelf.client getConversation:weakSelf.friendUsername :weakSelf.authToken];
        [self performSelectorOnMainThread:@selector(success:) withObject:convo waitUntilDone:NO];
    }];
}

-(void)success:(NSArray *)convo {
    if(self.delegate){
        [self.delegate onConversationReceived:convo];
    }
}
@end
