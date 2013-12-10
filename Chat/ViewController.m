//
//  ViewController.m
//  Chat
//
//  Created by Kelton Person on 12/9/13.
//
//

#import "ViewController.h"

#import "TBinaryProtocol.h"
#import "TProtocol.h"
#import "THTTPClient.h"
#import "chat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    NSURL *endPoint = [NSURL URLWithString:@"http://127.0.0.1:8080"];
    THTTPClient *transport = [[THTTPClient alloc] initWithURL:endPoint];
    TBinaryProtocol *protocol = [[TBinaryProtocol alloc] initWithTransport:transport strictRead:YES strictWrite:YES];
    ChatAPIClient *client = [[ChatAPIClient alloc] initWithProtocol:protocol];
    
    @try {
        [client addNewUser:@"Kate"];
        NSLog(@"USER_ADDED");
    }
    @catch (UserAlreadyRegisteredException *ex) {
        NSLog(@"USER_ALREADY_EXIST");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
