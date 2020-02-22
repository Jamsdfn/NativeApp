#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+test.h"
#import "Account.h"



int main(int argc, const char * argv[]) {
    NSArray *arr = @[@10,@20,@30];
    NSLog(@"%@", arr);
    for(NSNumber *num in arr){
        NSLog(@"%d", num.intValue);
    }
    
    return 0;
}
