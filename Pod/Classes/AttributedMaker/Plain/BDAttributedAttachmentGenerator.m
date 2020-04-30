//
//  BDAttributedAttachmentGenerator.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/9.
//

#import "BDAttributedAttachmentGenerator.h"

@interface BDAttributedAttachmentGenerator()

@property (nonatomic, strong) UIImage *contentImage;

@property (nonatomic, assign) CGSize attachmentSize;

@property (nonatomic, strong) UIFont *alignFont;

@property (nonatomic, assign) BDAttributedAttachmentVerticalAlignment vAlignment;

@end

@implementation BDAttributedAttachmentGenerator

- (BDAttributedAttachmentGenerator *(^)(UIImage *))image
{
    return ^BDAttributedAttachmentGenerator *(UIImage *_Nonnull image){
        self.contentImage = image;
        return self;
    };
}

- (BDAttributedAttachmentGenerator *(^)(CGSize))size
{
    return ^BDAttributedAttachmentGenerator *(CGSize size){
        self.attachmentSize = size;
        return self;
    };
}

- (BDAttributedAttachmentGenerator *(^)(UIFont *))alignToFont
{
    return ^BDAttributedAttachmentGenerator *(UIFont *f){
        self.alignFont = f;
        return self;
    };
}

- (BDAttributedAttachmentGenerator *(^)(BDAttributedAttachmentVerticalAlignment))verticalAlignment
{
    return ^BDAttributedAttachmentGenerator *(BDAttributedAttachmentVerticalAlignment alignment){
        self.vAlignment = alignment;
        return self;
    };
}

- (NSAttributedString *)generateAttributedString
{
    if (!self.contentImage) {
        return nil;
    }
    
    //Attachment Size
    CGSize attachmentSize = CGSizeEqualToSize(self.attachmentSize, CGSizeZero) ? self.contentImage.size : self.attachmentSize;
    
    //Image Resize
    UIImage *image = self.contentImage;
    if (!CGSizeEqualToSize(self.contentImage.size, attachmentSize)) {
        image = [self.contentImage imageScaledToSize:attachmentSize];
    }
    
    //Bounds
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    if (self.alignFont) {
        CGFloat lineHeight = self.alignFont.ascender + self.alignFont.descender;
        if (self.vAlignment == BDAttributedAttachmentVerticalAlignmentTop) {
            bounds.origin.y = lineHeight - bounds.size.height;
        } else if(self.vAlignment == BDAttributedAttachmentVerticalAlignmentBottom) {
            bounds.origin.y = 0;
        } else if(self.vAlignment == BDAttributedAttachmentVerticalAlignmentCenter) {
            bounds.origin.y = (lineHeight - bounds.size.height)/2;
        }
    }
    
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = image;
    attachment.bounds = bounds;
    return [NSAttributedString attributedStringWithAttachment:attachment];
}

- (BDAttributedContentItem *)generateAsyncAttributedContent
{
    BDAttributedContentItem *item = [BDAttributedContentItem itemWithContent:[self generateAttributedString]];
    return item;
}

@end
