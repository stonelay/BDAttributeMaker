//
//  BDAttributedAttachmentGenerator.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/9.
//

#import <Foundation/Foundation.h>
#import "BDAttributedGeneratorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BDAttributedAttachmentVerticalAlignment) {
    BDAttributedAttachmentVerticalAlignmentBottom = 0,
    BDAttributedAttachmentVerticalAlignmentCenter = 1,
    BDAttributedAttachmentVerticalAlignmentTop = 2
};

/**
 以image attachment(NSTextAttachment)为内容的NSAttributedString生成器
 */
@interface BDAttributedAttachmentGenerator : NSObject<BDAttributedGeneratorProtocol>

//图片
@property (nonatomic, copy, readonly) BDAttributedAttachmentGenerator *(^image)(UIImage *);

//图片展示尺寸
@property (nonatomic, copy, readonly) BDAttributedAttachmentGenerator *(^size)(CGSize);

//对齐目标字体，和verticalAlignment一同起作用
@property (nonatomic, copy, readonly) BDAttributedAttachmentGenerator *(^alignToFont)(UIFont *);

//垂直对齐方式：
// BDAttributedAttachmentVerticalAlignmentBottom - 图片底部贴着baseline
// BDAttributedAttachmentVerticalAlignmentCenter - 图片和文字居中对齐
// BDAttributedAttachmentVerticalAlignmentTop - 图片顶部贴着ascender
@property (nonatomic, copy, readonly) BDAttributedAttachmentGenerator *(^verticalAlignment)(BDAttributedAttachmentVerticalAlignment);

@end

NS_ASSUME_NONNULL_END
