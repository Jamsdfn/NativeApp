//
//  Manager.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/31.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "Manager.h"
#import "DownloadManager.h"
@interface Manager()


@property (nonatomic, strong) NSMutableDictionary *downloaderChache;

@end

@implementation Manager

- (NSMutableDictionary *)downloaderChache{
    if (!_downloaderChache) {
        _downloaderChache = [NSMutableDictionary new];
    }
    return _downloaderChache;
}

+ (instancetype)sharedManager{
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (void)download:(NSString*)urlString successBlock:(void(^)(NSString *path))successBlock processBlock:(void(^)(float process))processBlock errorBlock:(void(^)(NSError *error))errorBlock{
    if (self.downloaderChache[urlString]) return;
    DownloadManager *downloader = [DownloadManager downloader:urlString successBlock:^(NSString * _Nonnull path) {
        // 移除缓存池
        [self.downloaderChache removeObjectForKey:urlString];
        if (successBlock) {
            successBlock(path);
        }
    } processBlock:processBlock errorBlock:^(NSError * _Nonnull error) {
        [self.downloaderChache removeObjectForKey:urlString];
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    [self.downloaderChache setObject:downloader forKey:urlString];
    [[NSOperationQueue new] addOperation:downloader];
}

-(void)pause:(NSString *)urlString{
    DownloadManager *downloader = self.downloaderChache[urlString];
    if (!downloader) {
        return;
    }
    [downloader pause];
    // 取消自定义operation
    [downloader cancel];
    [self.downloaderChache removeObjectForKey:urlString];
}

@end
