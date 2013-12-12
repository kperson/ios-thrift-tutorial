//
//  ChatClientFactory.h
//  Chat
//
//  Created by Kelton Person on 12/10/13.
//
//

#import "chat.h"

@interface ChatClientFactory : NSObject

+ (ChatClientFactory *)sharedInstance;

-(ChatAPIClient *)client;

@property (strong, nonatomic) NSString *authToken;


@end
