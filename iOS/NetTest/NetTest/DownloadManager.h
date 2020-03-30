//
//  DownloadManager.h
//  NetTest
//
//  Created by Jamsdfn on 2020/3/30.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadManager : NSObject<NSURLConnectionDataDelegate>

- (void)download:(NSString*)urlString;

@end

NS_ASSUME_NONNULL_END
