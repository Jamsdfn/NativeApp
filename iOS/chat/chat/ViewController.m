#import "ViewController.h"
#import "Message.h"
#import "MessageFrame.h"
#import "MessageCell.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

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
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillCHangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyboardWillCHangeFrame:(NSNotification *)noteInfo{
    // 监听通知，实现键盘出现时显示内容也往上抬，回收时也跟回来
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [noteInfo.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyboardY = rectEnd.origin.y;
    CGFloat tranformValue = keyboardY - self.view.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, tranformValue);
    }];
    // 让UITableView滚到最上面
    NSIndexPath *idx = [NSIndexPath indexPathForRow:self.messagesFrame.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
// 实现滚动键盘就缩回去
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 监听return键按下，则发送
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // 获取text
    NSString *text = textField.text;
    // 创建模型放入messagesFrame中
    [self sendMessage:text witType:MessageTypeMe];
    textField.text = @"";
    [self sendMessage:@"滚你妈的" witType:MessageTypeOther];
    return YES;
}
// 封装发送消息方法
- (void)sendMessage:(NSString *)msg witType:(MessageType)type{
    Message *model = [Message new];
    model.text = msg;
    model.type = type;
    // 获取当前时间
    NSDate *now = [NSDate date];
    NSDateFormatter *fomatter = [NSDateFormatter new];
    fomatter.dateFormat = @"今天 HH:mm";
    model.time = [fomatter stringFromDate:now];
    
    MessageFrame *lastFrame = [self.messagesFrame lastObject];
    Message *lastMessage = lastFrame.message;
    if ([lastMessage.time isEqualToString:model.time]) {
        model.hideTime = YES;
    }
    MessageFrame *frame = [MessageFrame new];
    frame.message = model;
    [self.messagesFrame addObject:frame];
    // reload
    [self.tableView reloadData];
    // 最后一行滚动到最上面
    NSIndexPath *idx = [NSIndexPath indexPathForRow:self.messagesFrame.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (NSMutableArray *)messagesFrame{
    // 懒加载
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
