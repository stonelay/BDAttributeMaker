//
//  BDAttributedSpaceGenerator.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/9.
//

#import "BDAttributedSpaceGenerator.h"
#import "BDAttributedGeneratorProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 以pt为单位的空白区域生成器，支持UILabel+NSAttributedString
 */
@interface BDAttributedSpaceGenerator : NSObject<BDAttributedGeneratorProtocol>

//pt为单位的空白宽度
- (instancetype)initWithWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
