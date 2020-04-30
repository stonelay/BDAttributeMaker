//
//  BDAttributedGroupAttributesSetter.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/13.
//

#import "BDAttributedGroupAttributesSetter.h"

@interface BDAttributedGroupAttributesSetter()

@property (nonatomic, strong) NSMutableDictionary<NSAttributedStringKey, id> *attrs;

@end

@implementation BDAttributedGroupAttributesSetter

- (BDAttributedGroupAttributesSetter * _Nonnull (^)(NSAttributedStringKey _Nonnull, id _Nonnull))setAttribute
{
    return ^BDAttributedGroupAttributesSetter *(NSAttributedStringKey _Nonnull key, id _Nonnull value){
        if (key && value) {
            [self.attrs setValue:value forKey:key];
        }
        return self;
    };
}

#pragma mark - Accessor

- (NSDictionary<NSAttributedStringKey,id> *)attributes
{
    return self.attrs;
}

- (NSMutableDictionary<NSAttributedStringKey,id> *)attrs
{
    if (!_attrs) {
        _attrs = @{}.mutableCopy;
    }
    return _attrs;
}

@end
