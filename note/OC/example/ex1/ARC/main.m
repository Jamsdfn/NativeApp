#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+test.h"
#import "Account.h"

#define log(var) NSLog(@"%@", var==YES?@"YES":@"NO")

int main(int argc, const char * argv[]) {
    Person *p1 = [Person new];
    Person *p2 = [Person new];
    Person *p3 = [Person new];
    Person *p4 = [Person new];
    p1.name = @"lili";
    p1.age = 12;
    p2.name = @"lili";
    p2.age = 12;
    p3.name = @"lili";
    p3.age = 12;
    p4.name = @"lili";
    p4.age = 12;
    NSDictionary *dict = [p1 dictionaryWithValuesForKeys:@[@"name", @"age"]];
    NSLog(@"%@",dict);
    return 0;
}
