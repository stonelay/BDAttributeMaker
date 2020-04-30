//
//  BDAttributedContentManager.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import "BDAttributedContentManager.h"
#import "BDAttributedContentItem.h"

@interface BDAttributedContentManager()

@property (nonatomic, strong) NSPointerArray *delegates;

@property (nonatomic, strong) NSMutableArray<BDAttributedContentItem *> *contents;

@end

@implementation BDAttributedContentManager

- (void)addContent:(BDAttributedContentItem *)content
{
    [self.contents addObject:content];
}

- (void)asyncMakeContents
{
    @weakify(self);
    [self.contents bk_each:^(BDAttributedContentItem *obj) {
        [obj asyncMakeWithCompletionHandler:^(NSAttributedString * _Nonnull str) {
            @strongify(self);
            [self notifyContentUpdate];
        }];
    }];
}

- (void)notifyContentUpdate
{
    for (NSUInteger i = 0; i < self.delegates.count; i++) {
        id<BDAttributedContentItemUpdateProtocol> delegate = [self.delegates pointerAtIndex:i];
        if ([delegate respondsToSelector:@selector(bd_attributedContentManagerDidUpdate:)]) {
            [delegate bd_attributedContentManagerDidUpdate:self];
        }
    }
}

#pragma mark - Delegates Handling

- (void)addDelegate:(id<BDAttributedContentItemUpdateProtocol>)delegate
{
    [self.delegates addPointer:(__bridge void *)delegate];
}

- (NSUInteger)indexOfDelegate:(id<BDAttributedContentItemUpdateProtocol>)delegate
{
    for (NSUInteger i = 0; i < self.delegates.count; i++) {
        if ([self.delegates pointerAtIndex:i] == (__bridge void*)delegate) {
            return i;
        }
    }
    return NSNotFound;
}

- (void)removeDelegate:(id<BDAttributedContentItemUpdateProtocol>)delegate
{
    NSUInteger index = [self indexOfDelegate:delegate];
    if (index != NSNotFound) {
        [self.delegates removePointerAtIndex:index];
    }
    [self.delegates compact];
}

#pragma mark - Accessors

- (BOOL)isCompleted
{
    return [self.contents bk_all:^BOOL(BDAttributedContentItem *obj) {
        return obj.isCompleted;
    }];
}

- (NSMutableAttributedString *)content
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    [self.contents bk_each:^(BDAttributedContentItem *obj) {
        if (obj.text) {
            NSRange range = NSMakeRange(text.length, obj.text.length);
            [text appendAttributedString:obj.text];
            if (obj.additionalAttributes.allKeys.count) {
                [text addAttributes:obj.additionalAttributes range:range];
            }
        }
    }];
    return text;
}

- (NSPointerArray *)delegates
{
    if (!_delegates) {
        _delegates = [NSPointerArray weakObjectsPointerArray];
    }
    return _delegates;
}

- (NSMutableArray<BDAttributedContentItem *> *)contents
{
    if (!_contents) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}

@end
