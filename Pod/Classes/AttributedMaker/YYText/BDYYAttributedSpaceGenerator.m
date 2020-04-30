//
//  BDYYAttributedSpaceGenerator.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import "BDYYAttributedSpaceGenerator.h"

@interface BDYYAttributedSpaceGenerator()

@property (nonatomic, assign) CGFloat spaceWidth;

@end

@implementation BDYYAttributedSpaceGenerator

- (instancetype)initWithSpaceWidth:(CGFloat)width
{
    self = [super init];
    if (self) {
        self.spaceWidth = width;
    }
    return self;
}

- (NSAttributedString *)generateAttributedString
{
    if (self.spaceWidth <= 0){
        return nil;
    }
        
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.width = self.spaceWidth;
    CTRunDelegateRef delegateRef = delegate.CTRunDelegate;
    
    NSMutableAttributedString *blank = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [blank yy_setRunDelegate:delegateRef range:NSMakeRange(0, YYTextAttachmentToken.length)];
    
    @onExit {
        if (delegate) CFRelease(delegateRef);
    };
    return blank;
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    return [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
}

@end
