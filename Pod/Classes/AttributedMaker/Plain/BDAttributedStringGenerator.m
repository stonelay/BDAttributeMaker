//
//  BDAttributedStringGenerator.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import "BDAttributedStringGenerator.h"

@interface BDAttributedStringGenerator()

@property (nonatomic, strong) NSMutableDictionary<NSAttributedStringKey, id> *attrs;
@property (nonatomic, copy) NSString *str;

@end

@implementation BDAttributedStringGenerator

- (instancetype)initWithString:(NSString *)str
{
    self = [super init];
    if (self) {
        self.str = str;
        self.attrs = @{}.mutableCopy;
    }
    return self;
}

- (BDAttributedStringGenerator * _Nonnull (^)(NSAttributedStringKey _Nonnull, id _Nonnull))setAttribute
{
    return ^BDAttributedStringGenerator *(NSAttributedStringKey _Nonnull key, id _Nonnull value){
        if (key && value) {
            [self.attrs setValue:value forKey:key];
        }
        return self;
    };
}

- (BDAttributedStringGenerator * _Nonnull (^)(CGFloat))fontSize
{
    return ^BDAttributedStringGenerator *(CGFloat s){
        [self.attrs setValue:[UIFont systemFontOfSize:s] forKey:NSFontAttributeName];
        return self;
    };
}

- (BDAttributedStringGenerator * _Nonnull (^)(CGFloat))boldFontSize
{
    return ^BDAttributedStringGenerator *(CGFloat s){
        [self.attrs setValue:[UIFont boldSystemFontOfSize:s] forKey:NSFontAttributeName];
        return self;
    };
}

- (BDAttributedStringGenerator * _Nonnull (^)(id<BDColorConvertible> _Nonnull))textColor
{
    return ^BDAttributedStringGenerator *(id<BDColorConvertible> c){
        if ([c respondsToSelector:@selector(bd_asColor)]) {
            [self.attrs setValue:[c bd_asColor] forKey:NSForegroundColorAttributeName];
        }
        return self;
    };
}

- (BDAttributedStringGenerator * _Nonnull (^)(CGFloat))baselineOffset
{
    return ^BDAttributedStringGenerator *(CGFloat offset){
        [self.attrs setValue:@(offset) forKey:NSBaselineOffsetAttributeName];
        return self;
    };
}

- (NSAttributedString *)generateAttributedString
{
    if ([self.str isKindOfClass:[NSString class]] && self.str.length > 0) {
        return [[NSAttributedString alloc] initWithString:self.str attributes:self.attrs];
    } else {
        return nil;
    }
}

- (NSDictionary<NSAttributedStringKey,id> *)attributes
{
    return self.attrs;
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    BDAttributedContentItem *item = [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
    return item;
}

@end
