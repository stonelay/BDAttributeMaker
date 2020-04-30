//
//  BDColorConvertible.m
//  BDUIKit
//
//  Created by tony zhou on 2019/11/28.
//

#import <Foundation/Foundation.h>
#import "BDColorConvertible.h"

@implementation NSNumber (BDColorConvertible)

- (UIColor *)bd_asColor
{
    return [UIColor hb_colorWithHex:self.integerValue];
}

@end

@implementation NSString (BDColorConvertible)

- (UIColor *)bd_asColor
{
    return [UIColor hb_colorWithStringHex:self];
}

@end

@implementation UIColor (BDColorConvertible)

- (UIColor *)bd_asColor
{
    return self;
}

@end
