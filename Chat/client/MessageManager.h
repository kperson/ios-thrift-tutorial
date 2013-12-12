//
//  MessageManager.h
//  Chat
//
//  Created by Kelton Person on 12/11/13.
//
//

#import <Foundation/Foundation.h>

@protocol MessageReceivedHandler <NSObject>

-(void)onMessageReceived:(NSString *)message;

@end


@interface MessageManager : NSObject

+ (MessageManager *)sharedInstance;
-(void)messageReceived:(NSString *)message;

@property(weak, nonatomic) id<MessageReceivedHandler> handler;


@end
