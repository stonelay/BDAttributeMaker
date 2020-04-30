//
//  BDAttributeImageGenerator.h
//  BDUIKit
//
//  Created by tony zhou on 2019/11/28.
//

#import <Foundation/Foundation.h>
#import "BDAttributedGeneratorProtocol.h"
#import "BDTagAttributeString.h"
#import "YYText.h"

NS_ASSUME_NONNULL_BEGIN

/**
 基类，承担-[NSAttributedString yy_attachmentStringWithContent:contentMode:attachmentSize:alignToFont:alignment:]方法创建的attachment string共有属性
 详细信息参考YYText
 */
@interface BDYYAttributedAttachmentGenerator : NSObject

@property (nonatomic, copy, readonly) BDYYAttributedAttachmentGenerator *(^contentMode)(UIViewContentMode);

@property (nonatomic, copy, readonly) BDYYAttributedAttachmentGenerator *(^attachmentSize)(CGSize);

@property (nonatomic, copy, readonly) BDYYAttributedAttachmentGenerator *(^alignToFont)(UIFont *);

@property (nonatomic, copy, readonly) BDYYAttributedAttachmentGenerator *(^verticalAlignment)(YYTextVerticalAlignment);

@end

/**
 本地图片attr string生成器
 */
@interface BDYYAttributedImageAttachmentGenerator : BDYYAttributedAttachmentGenerator<BDAttributedGeneratorProtocol>

- (instancetype)initWithImage:(UIImage *)image;

@end

/**
网络图片attr string生成器
*/
@interface BDYYAttributedWebImageAttachmentGenerator : BDYYAttributedAttachmentGenerator<BDAttributedGeneratorProtocol>

- (instancetype)initWithImageUrl:(id<HBURLConvertible>)url;

@end

/**
内嵌视图attr string生成器
*/
@interface BDYYAttributedViewAttachmentGenerator : BDYYAttributedAttachmentGenerator<BDAttributedGeneratorProtocol>

- (instancetype)initWithView:(UIView *)view;

@end

// yyattribute 支持tagstring
@interface BDYYAttributedTagViewAttachmentGenerator : BDYYAttributedAttachmentGenerator<BDAttributedGeneratorProtocol>

- (instancetype)initWithTagString:(BDTagAttributeString *)tagString;

@end


NS_ASSUME_NONNULL_END
