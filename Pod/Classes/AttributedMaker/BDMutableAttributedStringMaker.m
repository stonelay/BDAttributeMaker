//
//  BDMutableAttributedStringMaker.m
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import "BDMutableAttributedStringMaker.h"

@interface BDBaseMutableAttributedStringMaker()

@property (nonatomic, strong) NSMutableArray<id<BDAttributedGeneratorProtocol>> *generators;

@property (nonatomic, strong) NSMutableArray<BDAttributedStringGroup *> *openingGroups;

@end

@implementation BDBaseMutableAttributedStringMaker

- (BDAttributedGroupAttributesSetter * _Nonnull (^)(void (^ _Nonnull)()))group
{
    return ^BDAttributedGroupAttributesSetter *((void (^ _Nonnull block)())){
        [self enterGroup];
        if (block) {
            block();
        }
        BDAttributedStringGroup *g = [self leaveGroup];
        return g.attributeSetter;
    };
}

- (void)addGenerator:(id<BDAttributedGeneratorProtocol>)generator
{
    objc_setAssociatedObject(generator, @selector(openingGroups), self.openingGroups, OBJC_ASSOCIATION_COPY);
    [self.generators addObject:generator];
}

- (BDAttributedContentManager *)contentManager
{
    BDAttributedContentManager *manager = [[BDAttributedContentManager alloc] init];
    [self.generators bk_each:^(id<BDAttributedGeneratorProtocol> obj) {
        BDAttributedContentItem *item = [obj generateAsyncAttributedContent];
        if (item) {
            NSMutableDictionary *groupAttrs = @{}.mutableCopy;
            NSArray<BDAttributedStringGroup *> *groups = (NSArray<BDAttributedStringGroup *> *)objc_getAssociatedObject(obj, @selector(openingGroups));
            [groups enumerateObjectsUsingBlock:^(BDAttributedStringGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [groupAttrs addEntriesFromDictionary:obj.attributeSetter.attributes];
            }];
            [item setAdditionalAttributes:groupAttrs];
            
            [manager addContent:item];
        }        
    }];
    return manager;
}

- (BDAttributedStringGroup *)enterGroup
{
    BDAttributedStringGroup *g = [BDAttributedStringGroup new];
    [self.openingGroups addObject:g];
    return g;
}

- (BDAttributedStringGroup *)leaveGroup
{
    BDAttributedStringGroup *g = self.openingGroups.lastObject;
    [self.openingGroups removeObject:g];
    return g;
}

- (NSMutableArray<BDAttributedStringGroup *> *)openingGroups
{
    if (!_openingGroups) {
        _openingGroups = [NSMutableArray array];
    }
    return _openingGroups;
}

- (NSMutableArray<id<BDAttributedGeneratorProtocol>> *)generators
{
    if (!_generators) {
        _generators = [NSMutableArray array];
    }
    return _generators;
}

@end

@implementation BDNSMutableAttributedStringMaker

- (BDAttributedRawStringGenerator * _Nonnull (^)(NSAttributedString * _Nonnull))raw
{
    return ^BDAttributedRawStringGenerator *(NSAttributedString *str){
        BDAttributedRawStringGenerator *generator = [[BDAttributedRawStringGenerator alloc] initWithRawString:str];
        [self addGenerator:generator];
        return generator;
    };
}

- (BDAttributedStringGenerator * _Nonnull (^)(NSString * _Nonnull))string
{
    return ^BDAttributedStringGenerator *(NSString *str){
        BDAttributedStringGenerator *generator = [[BDAttributedStringGenerator alloc] initWithString:str];
        [self addGenerator:generator];
        return generator;
    };
}

- (BDAttributedAttachmentGenerator * _Nonnull (^)(UIImage * _Nonnull))image
{
    return ^BDAttributedAttachmentGenerator *(UIImage *img) {
        BDAttributedAttachmentGenerator *generator = [[BDAttributedAttachmentGenerator alloc] init];
        if (img) {
            generator.image(img);
        }
        [self addGenerator:generator];
        return generator;
    };
}

- (BDAttributedSpaceGenerator * _Nonnull (^)(CGFloat))space
{
    return ^BDAttributedSpaceGenerator *(CGFloat s){
        BDAttributedSpaceGenerator *generator = [[BDAttributedSpaceGenerator alloc] initWithWidth:s];
        [self addGenerator:generator];
        return generator;
    };
}

@end

@implementation BDAsyncMutableAttributedStringMaker

- (BDAsyncAttributedWebImageGenerator * _Nonnull (^)(id<HBURLConvertible> _Nonnull))webImage
{
    return ^BDAsyncAttributedWebImageGenerator *(id<HBURLConvertible> url){
        BDAsyncAttributedWebImageGenerator *generator = [[BDAsyncAttributedWebImageGenerator alloc] initWithImageUrl:url];
        [self addGenerator:generator];
        return generator;
    };
}

- (BDAsyncAttributedTagViewGenerator * _Nonnull (^)(BDTagAttributeString * _Nonnull))asyncTagViewString
{
    return ^BDAsyncAttributedTagViewGenerator *(BDTagAttributeString *asyncTagViewString){
        BDAsyncAttributedTagViewGenerator *generator = [[BDAsyncAttributedTagViewGenerator alloc] initWithTagViewString:asyncTagViewString];
        [self addGenerator:generator];
        return generator;
    };
}

@end

@implementation BDYYMutableAttributedStringMaker

- (BDYYAttributedStringGenerator * _Nonnull (^)(NSString * _Nonnull))string
{
    return ^BDYYAttributedStringGenerator *(NSString *str){
        BDYYAttributedStringGenerator *generator = [[BDYYAttributedStringGenerator alloc] initWithString:str];
        [self addGenerator:generator];
        return generator;
    };
}

- (BDYYAttributedWebImageAttachmentGenerator * _Nonnull (^)(id<HBURLConvertible> _Nonnull))imageUrl
{
    @weakify(self);
    return ^BDYYAttributedWebImageAttachmentGenerator *(id<HBURLConvertible> url){
        @strongify(self);
        BDYYAttributedWebImageAttachmentGenerator *generator = [[BDYYAttributedWebImageAttachmentGenerator alloc] initWithImageUrl:url];
        [self addGenerator:generator];
        return generator;
    };
}

- (BDYYAttributedImageAttachmentGenerator * _Nonnull (^)(UIImage * _Nonnull))image
{
    @weakify(self);
    return ^BDYYAttributedImageAttachmentGenerator *(UIImage *img){
        @strongify(self);
        BDYYAttributedImageAttachmentGenerator *generator = [[BDYYAttributedImageAttachmentGenerator alloc] initWithImage:img];
        [self addGenerator:generator];
        return generator;
    };
}

- (BDYYAttributedTagViewAttachmentGenerator * _Nonnull (^)(BDTagAttributeString * _Nonnull))tagString
{
    @weakify(self);
    return ^BDYYAttributedTagViewAttachmentGenerator *(BDTagAttributeString *tagString){
        @strongify(self);
        BDYYAttributedTagViewAttachmentGenerator *generator = [[BDYYAttributedTagViewAttachmentGenerator alloc] initWithTagString:tagString];
        [self addGenerator:generator];
        return generator;
    };
}

- (BDYYAttributedViewAttachmentGenerator * _Nonnull (^)(UIView * _Nonnull))view
{
    @weakify(self);
    return ^BDYYAttributedViewAttachmentGenerator *(UIView *view){
        @strongify(self);
        BDYYAttributedViewAttachmentGenerator *generator = [[BDYYAttributedViewAttachmentGenerator alloc] initWithView:view];
        [self addGenerator:generator];
        return generator;
    };
}

- (BDYYAttributedSpaceGenerator * _Nonnull (^)(CGFloat))space
{
    @weakify(self);
    return ^BDYYAttributedSpaceGenerator *(CGFloat s){
        @strongify(self);
        BDYYAttributedSpaceGenerator *generator = [[BDYYAttributedSpaceGenerator alloc] initWithSpaceWidth:s];
        [self addGenerator:generator];
        return generator;
    };
}

@end
