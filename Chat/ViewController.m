//
//  ViewController.m
//  Chat
//
//  Created by Kelton Person on 12/9/13.
//
//

#import "ViewController.h"

#import "AddUserService.h"
#import "ChatClientFactory.h"
#import "ChatConstants.h"
#import "MessageManager.h"
#import "GetConversationService.h"
#import "ChatCell.h"
#import "SendMessageService.h"
#import "chat.h"

static NSString *kelton = @"Kelton";
static NSString *brian = @"Brian";
static NSString *ChatCellId = @"ChatCellId";

@interface ViewController ()<AddUserDelegate, MessageReceivedHandler, GetConversationDelegate>

@property (strong, nonatomic) AddUserService *addUserService;
@property (strong, nonatomic) GetConversationService *conversationService;
@property (strong, nonatomic) SendMessageService *sendMessageService;
@property (strong, nonatomic) NSMutableArray *convo;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MessageManager sharedInstance].handler = self;
     self.addUserService = [[AddUserService alloc] initWithUserName:kelton delegate:self];
    [self.addUserService execute];
}

-(void)onUserAdded:(NSString *)token {
    [ChatClientFactory sharedInstance].authToken = token;
    [self registerForPushNotifications];
    [self loadConversation];
}

-(void)onMessageReceived:(NSString *)message {
    ChatMessage *cMessage = [[ChatMessage alloc] initWithContent:message sender:brian recipient:kelton];
    [self.convo insertObject:cMessage atIndex:0];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)loadConversation {
    self.conversationService = [[GetConversationService alloc] initWithFriendName:brian authToken:[ChatClientFactory sharedInstance].authToken delegate:self];
    [self.conversationService execute];

}

-(void)onConversationReceived:(NSArray *)conversation {
    [self bindConversation:conversation];
}

-(void)bindConversation:(NSArray *)conversation {
    self.convo =  [self reversedArray:[[NSMutableArray alloc] initWithArray:conversation]];
    [self.tableView reloadData];
}



#pragma mark - Table View DataSoure

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = (ChatCell *)[tableView dequeueReusableCellWithIdentifier:ChatCellId];
    ChatMessage *msg = [self.convo objectAtIndex:indexPath.row];
    if (cell == nil) {
    	cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatCell" owner:self options:nil] objectAtIndex:0];
    }
    if([msg.sender isEqualToString:kelton]){
        cell.meLabel.text = msg.sender;
        cell.otherLabel.text = @"";
        cell.messageLabel.textAlignment = NSTextAlignmentRight;
    }
    else{
        cell.meLabel.text = @"";
        cell.otherLabel.text = msg.sender;
        cell.messageLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    cell.messageLabel.text = msg.content;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.convo ? self.convo.count : 0;
}

#pragma mark - Table View Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}


- (IBAction)sendButtonTapped:(id)sender {
    [self.view endEditing:YES];
    if(self.messageField.text.length != 0){
        [self sendMessage:self.messageField.text];
        self.messageField.text = @"";
    }
}

-(void)sendMessage:(NSString *)message {
    ChatMessage *cMessage = [[ChatMessage alloc] initWithContent:message sender:kelton recipient:brian];
    [self.convo insertObject:cMessage atIndex:0];
    [self.tableView reloadData];
    NSString *token = [ChatClientFactory sharedInstance].authToken;
    self.sendMessageService = [[SendMessageService alloc] initWithMessage:message username:brian authToken:token];
    [self.sendMessageService execute];
}

#pragma mark - Push Notification Registration
-(void)registerForPushNotifications {
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}


- (NSMutableArray *)reversedArray:(NSArray *)arrayToReverse {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arrayToReverse count]];
    NSEnumerator *enumerator = [arrayToReverse reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}
@end