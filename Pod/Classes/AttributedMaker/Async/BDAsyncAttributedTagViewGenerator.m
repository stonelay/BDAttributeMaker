//
//  BDAsyncAttributedTagViewGenerator.m
//  BDUIKit
//
//  Created by Lay on 2020/1/21.
//

#import "BDAsyncAttributedTagViewGenerator.h"
#import "BDTagDrawMaker.h"

@interface BDAsyncAttributedTagViewGenerator()

@property (nonatomic, strong) BDTagAttributeString *tagString;

@end

@implementation BDAsyncAttributedTagViewGenerator

- (instancetype)initWithTagViewString:(BDTagAttributeString *)tagViewString
{
    if (self = [super init]) {
        self.tagString = tagViewString;
        self.size(tagViewString.drawTagViewSize);
    }
    return self;
}

- (BDAttributedContentItem * _Nullable)generateAsyncAttributedContent
{
    BDAttributedContentItem *item = [BDAttributedContentItem new];
    
    if ([self.tagString isKindOfClass:BDTagAttributeString.class]) {
        item = [BDAttributedContentItem itemWithAsyncMakeBlock:^(BDAttributedContentItemMakeCompletionBlock _Nonnull block) {
            [[BDTagDrawManager sharedManager] drawTagView:self.tagString completion:^(UIImage * _Nullable image, NSString * _Nonnull errorMsg, BDTagAttributeString * _Nonnull tagString) {
                if (block) {
                    block([self.image(image) generateAttributedString]);
                }
            }];
        } placeHolderContent:[self generateAttributedString]];
    }
    return item;
}

@end
