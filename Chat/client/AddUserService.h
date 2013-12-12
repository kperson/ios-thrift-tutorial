//
//  AddUserService.h
//  Chat
//
//  Created by Kelton Person on 12/10/13.
//
//

#import "BaseService.h"

@protocol AddUserDelegate <NSObject>

-(void)onUserAdded:(NSString *)token;

@end

@interface AddUserService : BaseService

-(id)initWithUserName:(NSString *)username delegate:(id<AddUserDelegate>)delegate;

-(void)execute;

@end
