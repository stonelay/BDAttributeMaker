//
//  BDAttributedContentItem.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BDAttributedContentItemType) {
    BDAttributedContentItemTypeNormal = 0,
    BDAttributedContentItemTypeAsync = 1
};

typedef void (^BDAttributedContentItemMakeCompletionBlock)(NSAttributedString *);

/**
 富文本内容片段
 为支持异步获取/组装富文本内容，富文本片段分为普通内容（BDAttributedContentItemNormal）和异步获取的内容（BDAttributedContentItemAsync）
 1. 普通片段初始化时直接指定内容
 2. 异步片段初始化时指定内容获取逻辑（block）
 */
@interface BDAttributedContentItem : NSObject

//内容类型
@property (nonatomic, readonly) BDAttributedContentItemType type;

//富文本内容
@property (nonatomic, readonly) NSAttributedString *text;

//内容是否完整
@property (nonatomic, readonly) BOOL isCompleted;

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *additionalAttributes;

+ (instancetype _Nullable)itemWithAsyncMakeBlock:(void (^)(BDAttributedContentItemMakeCompletionBlock))block
                    placeHolderContent:(NSAttributedString *)placeholder;

+ (instancetype _Nullable)itemWithContent:(NSAttributedString *)attributedString;

- (void)asyncMakeWithCompletionHandler:(void(^)(NSAttributedString *))completionHandler;

@end

NS_ASSUME_NONNULL_END
