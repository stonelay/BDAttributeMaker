//
//  BDAttributedRawStringGenerator.m
//  BDUIKit
//
//  Created by tony zhou on 2020/1/3.
//

#import "BDAttributedRawStringGenerator.h"

@interface BDAttributedRawStringGenerator()

@property (nonatomic, strong) NSAttributedString *attrStr;

@end

@implementation BDAttributedRawStringGenerator

- (instancetype)initWithRawString:(NSAttributedString *)str
{
    self = [super init];
    if (self) {
        self.attrStr = str;
    }
    return self;
}

- (NSAttributedString *)generateAttributedString
{
    if ([self.attrStr isKindOfClass:[NSAttributedString class]]) {
        return self.attrStr;
    }
    return nil;
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    BDAttributedContentItem *item = [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
    return item;
}

@end
