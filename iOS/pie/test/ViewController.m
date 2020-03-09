#import "ViewController.h"
#import "MYView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet MYView *canvas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.value = 0;
    [self.slider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderChanged{
    [self.canvas setProgressValue:self.slider.value];
}

@end
