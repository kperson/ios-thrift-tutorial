//
//  ViewController.h
//  Chat
//
//  Created by Kelton Person on 12/9/13.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *messageField;
- (IBAction)sendButtonTapped:(id)sender;

@end
