#import "ContryView.h"
#import "Contry.h"


@interface ContryView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblContryName;


@end

@implementation ContryView


- (void)setContry:(Contry *)contry{
    _contry = contry;
    self.lblContryName.text = contry.name;
    self.imgViewIcon.image = [UIImage imageNamed:contry.icon];
    
    
}

+ (instancetype)contryView {
    ContryView *contry = [[NSBundle mainBundle] loadNibNamed:@"ContryView" owner:nil options:nil][0];
    return contry;
}

@end
