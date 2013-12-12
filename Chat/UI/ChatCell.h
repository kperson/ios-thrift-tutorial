//
//  ChatCell.h
//  Chat
//
//  Created by Kelton Person on 12/11/13.
//
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *otherLabel;
@property (strong, nonatomic) IBOutlet UILabel *meLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@end
