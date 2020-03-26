//
//  NSDictionary+EX.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/26.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "NSDictionary+EX.h"




@implementation NSDictionary (EX)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    NSMutableString *msg = [NSMutableString new];
    [msg appendString:@"\r\n{\r\n"];
    for (id key in self) {
        [msg appendFormat:@"\t%@: %@,\r\n", key, self[key]];
    }
    [msg appendString:@"}"];
    return msg.copy;
}
@end

@implementation NSArray (EX)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    NSMutableString *msg = [NSMutableString new];
    [msg appendString:@"\r\n[\r\n"];
    for (id key in self) {
        [msg appendFormat:@"\t\t%@,\r\n", key];
    }
    [msg appendString:@"]"];
    return msg.copy;
}
@end
