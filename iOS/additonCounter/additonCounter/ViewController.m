#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *img;
- (IBAction)move:(UIButton *)sender;
- (IBAction)scale:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)move:(UIButton *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    CGRect frame = self.img.frame;
    switch (sender.tag) {
        case 0:
            frame.origin.y -= 100;
            break;
        case 1:
            frame.origin.x += 100;
            break;
        case 2:
            frame.origin.y += 100;
            break;
        case 3:
            frame.origin.x -= 100;
            break;
    }
    self.img.frame =  frame;
    [UIView commitAnimations];
    
}

- (IBAction)scale:(UIButton *)sender {
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.5];
    CGRect frame = self.img.frame;
    if (sender.tag == 4) {
        frame.size.width += 100;
        frame.size.height += 100;
    } else {
        frame.size.width -= 100;
        frame.size.height -= 100;
    }
//    self.img.frame = frame;
//    [UIView commitAnimations];
    [UIView animateWithDuration:1 animations:^{
        self.img.frame = frame;
    }];
}
@end
