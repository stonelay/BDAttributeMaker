//
//  BDAttributedRawStringGenerator.h
//  BDUIKit
//
//  Created by tony zhou on 2020/1/3.
//

#import <Foundation/Foundation.h>
#import "BDAttributedGeneratorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDAttributedRawStringGenerator : NSObject<BDAttributedGeneratorProtocol>

- (instancetype)initWithRawString:(NSAttributedString *)str;

@end

NS_ASSUME_NONNULL_END
