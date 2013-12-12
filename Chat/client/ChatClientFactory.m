//
//  ChatClientFactory.m
//  Chat
//
//  Created by Kelton Person on 12/10/13.
//
//

#import "ChatClientFactory.h"
#import "TBinaryProtocol.h"
#import "TProtocol.h"
#import "THTTPClient.h"
#import "chat.h"


@interface ChatClientFactory ()

@property (strong, nonatomic) ChatAPIClient *myClient;

@end

@implementation ChatClientFactory


+ (ChatClientFactory *)sharedInstance
{
    //  Static local predicate must be initialized to 0
    static ChatClientFactory *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ChatClientFactory alloc] init];
    });
    return sharedInstance;
}

-(ChatAPIClient *)client {
    if(!self.myClient){
        //NSURL *endPoint = [NSURL URLWithString:@"http://server-env-kyr2mdefeg.elasticbeanstalk.com"];
        //NSURL *endPoint = [NSURL URLWithString:@"http://192.168.2.166:8080"];
        NSURL *endPoint = [NSURL URLWithString:@"http://192.168.0.100:8080"];
        THTTPClient *transport = [[THTTPClient alloc] initWithURL:endPoint];
        TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:transport strictRead:YES strictWrite:YES];
        return [[ChatAPIClient alloc] initWithProtocol:protocol];
    }
    return self.myClient;
}

@end