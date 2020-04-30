//
//  BDAttributedSpaceGenerator.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/9.
//

#import "BDAttributedSpaceGenerator.h"

@interface BDAttributedSpaceGenerator()

@property (nonatomic, assign) CGFloat spaceWidth;

@end

@implementation BDAttributedSpaceGenerator

- (instancetype)initWithWidth:(CGFloat)width
{
    self = [super init];
    if (self) {
        self.spaceWidth = width;
    }
    return self;
}

- (NSAttributedString *)generateAttributedString
{
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:@" "
                                                               attributes:@{NSKernAttributeName : @(self.spaceWidth),
                                                                            NSFontAttributeName : [UIFont systemFontOfSize:1]}];
    return text;
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    return [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
}

@end
