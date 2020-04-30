//
//  BDMutableAttributedStringMaker.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "BDAttributedRawStringGenerator.h"
#import "BDAttributedStringGenerator.h"
#import "BDAttributedAttachmentGenerator.h"
#import "BDAsyncAttributedWebImageGenerator.h"
#import "BDAttributedSpaceGenerator.h"
#import "BDAttributedContentManager.h"
#import "BDAttributedStringGroup.h"
#import "BDYYAttributedAttachmentGenerator.h"
#import "BDYYAttributedSpaceGenerator.h"
#import "BDYYAttributedStringGenerator.h"
#import "BDTagAttributeString.h"
#import "BDAsyncAttributedTagViewGenerator.h"

NS_ASSUME_NONNULL_BEGIN

@interface BDBaseMutableAttributedStringMaker : NSObject

@property (nonatomic, copy, readonly) BDAttributedGroupAttributesSetter *(^group)(void(^)());

- (BDAttributedContentManager *)contentManager;

@end

@interface BDNSMutableAttributedStringMaker : BDBaseMutableAttributedStringMaker

@property (nonatomic, copy, readonly) BDAttributedRawStringGenerator *(^raw)(NSAttributedString *);

@property (nonatomic, copy, readonly) BDAttributedStringGenerator *(^string)(NSString *);

@property (nonatomic, copy, readonly) BDAttributedAttachmentGenerator *(^image)(UIImage *);

@property (nonatomic, copy, readonly) BDAttributedSpaceGenerator *(^space)(CGFloat);

@end

@interface BDAsyncMutableAttributedStringMaker : BDNSMutableAttributedStringMaker

@property (nonatomic, copy, readonly) BDAsyncAttributedWebImageGenerator *(^webImage)(id<HBURLConvertible>);

@property (nonatomic, copy, readonly) BDAsyncAttributedTagViewGenerator *(^asyncTagViewString)(BDTagAttributeString *);

@end

@interface BDYYMutableAttributedStringMaker : BDBaseMutableAttributedStringMaker

@property (nonatomic, copy, readonly) BDYYAttributedStringGenerator *(^string)(NSString *);

//本地图片
@property (nonatomic, copy, readonly) BDYYAttributedImageAttachmentGenerator *(^image)(UIImage *);

//tagString
@property (nonatomic, copy, readonly) BDYYAttributedTagViewAttachmentGenerator *(^tagString)(BDTagAttributeString *);

//网络图片
//支持传入NSNumber<@(0xf2f4f6)>、NSString(@"#f2f4f6")、UIColor
@property (nonatomic, copy, readonly) BDYYAttributedWebImageAttachmentGenerator *(^imageUrl)(id<HBURLConvertible>);

//视图
@property (nonatomic, copy, readonly) BDYYAttributedViewAttachmentGenerator *(^view)(UIView *);

//空白分隔
@property (nonatomic, copy, readonly) BDYYAttributedSpaceGenerator *(^space)(CGFloat);


@end

NS_ASSUME_NONNULL_END
