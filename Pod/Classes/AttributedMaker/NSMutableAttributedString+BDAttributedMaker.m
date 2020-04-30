//
//  NSMutableAttributedString+BDAttributedMaker.m
//  BDUIKit
//
//  Created by tony zhou on 2019/11/28.
//

#import "NSMutableAttributedString+BDAttributedMaker.h"
#import "BDAttributedContentManager.h"

@implementation NSMutableAttributedString (BDAttributedMaker)

+ (instancetype)bd_makeNSAttributedString:(void (^)(BDNSMutableAttributedStringMaker * _Nonnull))block
{
    BDNSMutableAttributedStringMaker *maker = [[BDNSMutableAttributedStringMaker alloc] init];
    if (block) {
        block(maker);
    }
    BDAttributedContentManager *contentManager = [maker contentManager];
    return contentManager.content;
}

+ (instancetype)bd_makeYYAttributedString:(void (^)(BDYYMutableAttributedStringMaker * _Nonnull))block
{
    BDYYMutableAttributedStringMaker *maker = [[BDYYMutableAttributedStringMaker alloc] init];
    if (block) {
        block(maker);
    }
    BDAttributedContentManager *contentManager = [maker contentManager];
    return contentManager.content;
}

+ (instancetype)bd_makeContent:(void (^)(BDYYMutableAttributedStringMaker * _Nonnull m))block
{
    return [self bd_makeYYAttributedString:block];
}

@end
