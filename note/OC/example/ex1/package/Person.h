#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSString *_name;
    int _age;
    float _height;
    float _weight;
}

@property int age;
@property NSString *name;
@property float height;
@property float weight;


- (void)show;

@end
