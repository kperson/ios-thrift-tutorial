//
//  AddUserService.m
//  Chat
//
//  Created by Kelton Person on 12/10/13.
//
//

#import "AddUserService.h"
#import "ChatClientFactory.h"

@interface AddUserService ()

@property (strong, nonatomic) NSString *username;
@property (weak, nonatomic) id<AddUserDelegate> delegate;
@property (strong, nonatomic) NSOperationQueue *asyncQueue;
@property (strong, nonatomic) ChatAPIClient *client;

@end

@implementation AddUserService

-(id)initWithUserName:(NSString *)username delegate:(id<AddUserDelegate>)delegate {
    self = [super init];
    if(self){
        self.username = username;
        self.delegate = delegate;
    }
    return self;
}

-(void)execute {
    self.client = [[ChatClientFactory sharedInstance] client];
    self.asyncQueue = [self fetchAsyncQueue];
    __weak AddUserService *weakSelf = self;
    [self.asyncQueue addOperationWithBlock:^(void) {
        NSString *token = [weakSelf.client addNewUser:weakSelf.username];
        [self performSelectorOnMainThread:@selector(success:) withObject:token waitUntilDone:NO];
    }];
}


-(void)success:(NSString *)token {
    if(self.delegate){
        [self.delegate onUserAdded:token];
    }
}

@end
