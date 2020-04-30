//
//  BDColorConvertible.h
//  BDUIKit
//
//  Created by tony zhou on 2019/11/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BDColorConvertible <NSObject>

- (UIColor *)bd_asColor;

@end

@interface NSNumber(BDColorConvertible)<BDColorConvertible>

@end

@interface NSString(BDColorConvertible)<BDColorConvertible>

@end

@interface UIColor(BDColorConvertible)<BDColorConvertible>

@end

NS_ASSUME_NONNULL_END
