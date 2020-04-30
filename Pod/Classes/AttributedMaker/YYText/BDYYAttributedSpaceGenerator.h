//
//  BDYYAttributedSpaceGenerator.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "BDAttributedGeneratorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDYYAttributedSpaceGenerator : NSObject<BDAttributedGeneratorProtocol>

- (instancetype)initWithSpaceWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
