//
//  BDAttributedStringGenerator.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "BDColorConvertible.h"
#import "BDAttributedGeneratorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
NSAttributedString生成器 - 支持用链式语法设置NSAttributedString属性
*/
@interface BDAttributedStringGenerator : NSObject<BDAttributedGeneratorProtocol>

- (instancetype)initWithString:(NSString *)str;

//setAttribute为基本设置方法，支持传入如 NSForegroundColorAttributeName, [UIColor whiteColor] 类似的参数
// 👉 m.setAttribute(NSForegroundColorAttributeName, [UIColor whiteColor])
@property (nonatomic, copy, readonly) BDAttributedStringGenerator *(^setAttribute)(NSAttributedStringKey,id);

//设置为系统字体大小, 内部使用[UIFont systemFontOfSize:s]
@property (nonatomic, copy, readonly) BDAttributedStringGenerator *(^fontSize)(CGFloat);

//设置为粗体字体大小，内部使用[UIFont boldSystemFontOfSize:s]
@property (nonatomic, copy, readonly) BDAttributedStringGenerator *(^boldFontSize)(CGFloat);

//字体颜色，参数自动转换，支持NSString，NSNumber和UIColor
@property (nonatomic, copy, readonly) BDAttributedStringGenerator *(^textColor)(id<BDColorConvertible>);

//baselineOffset
@property (nonatomic, copy, readonly) BDAttributedStringGenerator *(^baselineOffset)(CGFloat);

@property (nonatomic, copy, readonly) NSDictionary<NSAttributedStringKey, id> *attributes;

@end

NS_ASSUME_NONNULL_END
