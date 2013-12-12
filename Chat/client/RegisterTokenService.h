//
//  RegisterTokenService.h
//  Chat
//
//  Created by Kelton Person on 12/10/13.
//
//

#import "BaseService.h"

@interface RegisterTokenService : BaseService

-(id)initWithPushToken:(NSString *)pushToken authToken:(NSString *)authToken;
-(void)execute;

@end
