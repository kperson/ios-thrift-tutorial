//
//  SendMessageService.h
//  Chat
//
//  Created by Kelton Person on 12/11/13.
//
//

#import "BaseService.h"

@interface SendMessageService : BaseService

-(void)execute;
-(id)initWithMessage:(NSString *)message username:(NSString *)username authToken:(NSString *)authToken;

@end
