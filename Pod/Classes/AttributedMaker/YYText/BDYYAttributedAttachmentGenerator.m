//
//  BDAttributeImageGenerator.m
//  BDUIKit
//
//  Created by tony zhou on 2019/11/28.
//

#import "BDYYAttributedAttachmentGenerator.h"
#import "BDTagDrawMaker.h"
#import "UIImageView+BDTagView.h"

@interface BDYYAttributedAttachmentGenerator()

@property (nonatomic, assign) UIViewContentMode yyContentMode;

@property (nonatomic, assign) CGSize yyattachmentSize;

@property (nonatomic, strong) UIFont *yyAlignToFont;

@property (nonatomic, assign) YYTextVerticalAlignment yyVerticalAlignment;

@end

@implementation BDYYAttributedAttachmentGenerator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.yyContentMode = UIViewContentModeScaleAspectFit;
        self.yyattachmentSize = CGSizeZero;
        self.yyAlignToFont = [UIFont systemFontOfSize:14];
        self.yyVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return self;
}

- (BDYYAttributedAttachmentGenerator * _Nonnull (^)(UIViewContentMode))contentMode
{
    return ^BDYYAttributedAttachmentGenerator *(UIViewContentMode m){
        self.yyContentMode = m;
        return self;
    };
}

- (BDYYAttributedAttachmentGenerator * _Nonnull (^)(CGSize))attachmentSize
{
    return ^BDYYAttributedAttachmentGenerator *(CGSize s){
        self.yyattachmentSize = s;
        return self;
    };
}

- (BDYYAttributedAttachmentGenerator * _Nonnull (^)(UIFont * _Nonnull))alignToFont
{
    return ^BDYYAttributedAttachmentGenerator *(UIFont *f){
        self.yyAlignToFont = f;
        return self;
    };
}

- (BDYYAttributedAttachmentGenerator * _Nonnull (^)(YYTextVerticalAlignment))verticalAlignment
{
    return ^BDYYAttributedAttachmentGenerator *(YYTextVerticalAlignment alignment){
        self.yyVerticalAlignment = alignment;
        return self;
    };
}

@end

@interface BDYYAttributedImageAttachmentGenerator()

@property (nonatomic, strong) UIImage *img;

@end

@implementation BDYYAttributedImageAttachmentGenerator

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.img = image;
    }
    return self;
}

- (NSAttributedString *_Nullable)generateAttributedString
{
    if (!self.img) {
        return nil;
    }
    return [NSMutableAttributedString yy_attachmentStringWithContent:self.img
                                                         contentMode:self.yyContentMode
                                                      attachmentSize:(CGSizeEqualToSize(CGSizeZero, self.yyattachmentSize) ? self.img.size : self.yyattachmentSize)
                                                         alignToFont:self.yyAlignToFont
                                                           alignment:self.yyVerticalAlignment];
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    return [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
}

@end

@interface BDYYAttributedWebImageAttachmentGenerator()

@property (nonatomic, strong) id<HBURLConvertible> url;

@end

@implementation BDYYAttributedWebImageAttachmentGenerator

- (instancetype)initWithImageUrl:(id<HBURLConvertible>)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (NSAttributedString *)generateAttributedString
{
    if (!self.url) {
        return nil;
    }
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = self.yyContentMode;
    imageView.size = self.yyattachmentSize;
    [imageView sd_setImageWithURL:[self.url hb_asURL]];
    
    return [NSAttributedString yy_attachmentStringWithContent:imageView
                                                  contentMode:self.yyContentMode
                                               attachmentSize:self.yyattachmentSize
                                                  alignToFont:self.yyAlignToFont
                                                    alignment:self.yyVerticalAlignment];
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    return [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
}

@end

@interface BDYYAttributedViewAttachmentGenerator()

@property (nonatomic, strong) UIView *view;

@end

@implementation BDYYAttributedViewAttachmentGenerator

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}

- (NSAttributedString *)generateAttributedString
{
    if (!self.view) {
        return nil;
    }
    
    return [NSAttributedString yy_attachmentStringWithContent:self.view
                                                  contentMode:self.yyContentMode
                                               attachmentSize:self.yyattachmentSize
                                                  alignToFont:self.yyAlignToFont
                                                    alignment:self.yyVerticalAlignment];
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    return [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
}

@end

@interface BDYYAttributedTagViewAttachmentGenerator()

@property (nonatomic, strong) BDTagAttributeString *tagString;

@end

@implementation BDYYAttributedTagViewAttachmentGenerator

- (instancetype)initWithTagString:(BDTagAttributeString *)tagString
{
    if (self = [super init]) {
        self.tagString = tagString;
        self.yyattachmentSize = self.tagString.drawTagViewSize;
    }
    return self;
}

- (NSAttributedString *)generateAttributedString
{
    if (!self.tagString) {
        return nil;
    }
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = self.yyContentMode;
    imageView.size = self.yyattachmentSize;
    [imageView bd_setTagViewWithTagString:self.tagString];
    
    return [NSAttributedString yy_attachmentStringWithContent:imageView
                                                  contentMode:self.yyContentMode
                                               attachmentSize:self.yyattachmentSize
                                                  alignToFont:self.yyAlignToFont
                                                    alignment:self.yyVerticalAlignment];
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    return [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
}

@end


