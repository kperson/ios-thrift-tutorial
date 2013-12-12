//
//  GetConversationService.h
//  Chat
//
//  Created by Kelton Person on 12/11/13.
//
//

#import "BaseService.h"

@protocol GetConversationDelegate <NSObject>

-(void)onConversationReceived:(NSArray *)conversation;

@end

@interface GetConversationService : BaseService

-(id)initWithFriendName:(NSString *)friend authToken:(NSString *)token delegate:(id<GetConversationDelegate>)delegate;
-(void)execute;

@end
