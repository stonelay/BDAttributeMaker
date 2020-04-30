//
//  BDAttributedStringGroup.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/11.
//

#import "BDAttributedStringGroup.h"

@interface BDAttributedStringGroup()

@property (nonatomic, strong) BDAttributedGroupAttributesSetter *attributeSetter;

@end

@implementation BDAttributedStringGroup

#pragma mark - Accessors

- (BDAttributedGroupAttributesSetter *)attributeSetter
{
    if (!_attributeSetter) {
        _attributeSetter = [BDAttributedGroupAttributesSetter new];
    }
    return _attributeSetter;
}

@end
