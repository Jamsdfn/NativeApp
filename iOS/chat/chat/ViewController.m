#import "ViewController.h"
#import "Message.h"
#import "MessageFrame.h"
#import "MessageCell.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messagesFrame;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self messagesFrame];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    self.tableView.allowsSelection = NO;
}

- (NSMutableArray *)messagesFrame{
    if (!_messagesFrame) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in arr){
            Message *model = [Message messageWithDictionary:item];
            MessageFrame *frame = [MessageFrame new];
            Message *lastMessage = (Message *)[[arrM lastObject] message];
            // 判断消息时间是否一致，如果一致做一个标记
            if ([model.time isEqualToString:lastMessage.time]) {
                model.hideTime = YES;
            }
            frame.message = model;
            [arrM addObject:frame];
        }
        _messagesFrame = arrM;
    }
    return _messagesFrame;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messagesFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageFrame *frame = self.messagesFrame[indexPath.row];
    
    static NSString *ID = @"message_cell";
    MessageCell *cell = [MessageCell messageCellWithTableView:tableView andIdentifier:ID];
    cell.messageFrame = frame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageFrame *frame = self.messagesFrame[indexPath.row];
    return frame.rowHeight;
}

@end
