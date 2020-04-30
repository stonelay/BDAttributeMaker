//
//  UILabel+BDAttributedMaker.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/9.
//
#import "UILabel+BDAsyncAttributedMaker.h"

@implementation UILabel (BDAsyncAttributedMaker)

- (void)bd_setAsyncAttributedStringWithMaker:(void (^)(BDAsyncMutableAttributedStringMaker * _Nonnull m))block
{
    id prevContentManager = [self bk_associatedValueForKey:@selector(bd_setAsyncAttributedStringWithMaker:)];
    if ([prevContentManager isKindOfClass:[BDAttributedContentManager class]]) {
        [prevContentManager removeDelegate:self];
    }
    
    BDAsyncMutableAttributedStringMaker *maker = [[BDAsyncMutableAttributedStringMaker alloc] init];
    if (block) {
        block(maker);
    }
    
    BDAttributedContentManager *contentManger = [maker contentManager];
    [contentManger asyncMakeContents];
    [self setAttributedText:contentManger.content];
    
    if (!contentManger.isCompleted) {
        [contentManger addDelegate:self];
        [self bk_associateValue:contentManger withKey:@selector(bd_setAsyncAttributedStringWithMaker:)];
    }
}

- (void)bd_unsetAsyncAttributedString
{
    id prevContentManager = [self bk_associatedValueForKey:@selector(bd_setAsyncAttributedStringWithMaker:)];
    if ([prevContentManager isKindOfClass:[BDAttributedContentManager class]]) {
        [prevContentManager removeDelegate:self];
        [self bk_associateValue:nil withKey:@selector(bd_setAsyncAttributedStringWithMaker:)];
    }
}

#pragma mark - BDAttributedContentItemUpdateProtocol

- (void)bd_attributedContentManagerDidUpdate:(BDAttributedContentManager *)manager
{
    [self setAttributedText:manager.content];
    if (manager.isCompleted) {
        [self bd_unsetAsyncAttributedString];
    }
}

@end
