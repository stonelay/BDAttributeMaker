//
//  BDAttributedContentItem.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import "BDAttributedContentItem.h"

@interface BDAttributedContentItem()

@property (nonatomic, copy) void (^asyncMakeBlock)(BDAttributedContentItemMakeCompletionBlock);

@property (nonatomic, readwrite, copy) NSAttributedString *text;

@property (nonatomic, readwrite, assign) BOOL isCompleted;

@property (nonatomic, readwrite, assign) BDAttributedContentItemType type;

@end

@implementation BDAttributedContentItem

+ (instancetype _Nullable)itemWithContent:(NSAttributedString *)attributedString
{
    BDAttributedContentItem *item = [[BDAttributedContentItem alloc] init];
    if (item) {
        item.text = attributedString;
        item.type = BDAttributedContentItemTypeNormal;
        item.isCompleted = YES;
    }
    return item;
}

+ (instancetype _Nullable)itemWithAsyncMakeBlock:(void (^)(BDAttributedContentItemMakeCompletionBlock _Nonnull))block placeHolderContent:(NSAttributedString *)placeholder
{
    BDAttributedContentItem *item = [[BDAttributedContentItem alloc] init];
    if (item) {
        item.text = placeholder;
        item.type = BDAttributedContentItemTypeAsync;
        item.isCompleted = NO;
        item.asyncMakeBlock = block;
    }
    return item;
}

- (void)asyncMakeWithCompletionHandler:(void (^)(NSAttributedString * _Nonnull))completionHandler
{
    if (self.asyncMakeBlock) {
        @weakify(self);
        self.asyncMakeBlock(^(NSAttributedString * _Nonnull str) {
            @strongify(self);
            if (str) {
                self.text = str;
            }
            if (!self.isCompleted) {
                self.isCompleted = YES;
                if (completionHandler) {
                    completionHandler(self.text);
                }
            }
            
        });
    }
}

@end
