#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NSStringExt)

+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
