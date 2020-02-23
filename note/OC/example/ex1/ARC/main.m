#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+test.h"
#import "Account.h"

#define log(var) NSLog(@"%@", var==YES?@"YES":@"NO")

int main(int argc, const char * argv[]) {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    NSInteger year = components.year;
    NSInteger month = components.month;
    NSInteger day = components.day;
    NSLog(@"%lu %lu %lu",year,month,day);
    return 0;
}
