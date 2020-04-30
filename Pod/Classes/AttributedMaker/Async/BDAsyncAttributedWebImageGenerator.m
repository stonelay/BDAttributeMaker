//
//  BDAsyncAttributedWebImageGenerator.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import "BDAsyncAttributedWebImageGenerator.h"

@implementation BDAttributedAttachmentGenerator (Placeholder)

- (BDAttributedAttachmentGenerator *(^)(UIImage *))placeholder
{
    return ^BDAttributedAttachmentGenerator *(UIImage *image){
        self.image(image);
        return self;
    };
}

@end

@interface BDAsyncAttributedWebImageGenerator()

@property (nonatomic, strong) id<HBURLConvertible> url;

@end

@implementation BDAsyncAttributedWebImageGenerator

- (instancetype)initWithImageUrl:(id<HBURLConvertible>)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (BDAttributedContentItem * _Nullable)generateAsyncAttributedContent
{
    BDAttributedContentItem *item = nil;
    NSURL *url = nil;
    if ([self.url respondsToSelector:@selector(hb_asURL)]) {
        url = [self.url hb_asURL];
    }
    
    if (url) {
        item = [BDAttributedContentItem itemWithAsyncMakeBlock:^(BDAttributedContentItemMakeCompletionBlock _Nonnull block) {
            
            [[SDWebImageManager sharedManager] loadImageWithURL:url
                                                        options:0
                                                       progress:nil
                                                      completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (block) {
                    block([self.image(image) generateAttributedString]);
                }
            }];
            
        } placeHolderContent:[self generateAttributedString]];
    }
    
    return item;
}

@end
