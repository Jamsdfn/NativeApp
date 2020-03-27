//
//  MResponse.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/26.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "MResponse.h"

@implementation MResponse

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (NSString *)time{
    int len = self.length.intValue;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", len/3600, len/60, len%60];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> {videoId: %@, name: %@, length: %@, videoURL: %@, imageURL: %@, desc: %@, teacher: %@, time: %@}", [self class], self, self.videoId, self.name, self.length, self.videoURL, self.imageURL, self.desc, self.teacher, self.time];
}

@end
