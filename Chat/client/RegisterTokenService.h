//
//  RegisterTokenService.h
//  Chat
//
//  Created by Kelton Person on 12/10/13.
//
//

#import "BaseService.h"

@protocol RegisterTokenDelegate <NSObject>

-(void)onTokenRegistered;

@end

@interface RegisterTokenService : BaseService

-(id)initWithPushToken:(NSString *)pushToken authToken:(NSString *)authToken delegate:(id<RegisterTokenDelegate>)delegte;
-(void)execute;

@end
