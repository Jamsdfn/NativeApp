#import <Foundation/Foundation.h>

double area(double a, double b) {
    return a * b;
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSLog(@"3*3=%f", area(3.0,3.0));
        // argc 就是第几个条件
        // 终端输入 ./ex1 -s aa
        //   argc==3 argv[0]=="./ex1" argv[1]=="-s" argv[2]=="aa"
        for (int i = 0; i< argc; i++) {
            NSLog(@"%s", argv[i]);
        }
    }
    return 0;

}
