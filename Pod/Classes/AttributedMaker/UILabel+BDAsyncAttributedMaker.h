//
//  UILabel+BDAsyncAttributedMaker.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/9.
//
#import <UIKit/UIKit.h>
#import "BDMutableAttributedStringMaker.h"

NS_ASSUME_NONNULL_BEGIN

/**
 异步的方式设置UILabel's attributedText
 引入背景 - 使用UILabel+NSAttributedString进行复杂图文混排存在各种编码体验上的缺陷：
    1. 组建AttributedString不够直观，代码上容易超宽，影响阅读体验
    2. 编码生成NSAttributedString的开发效率低下
    3. 图文混排时用NSTextAttachment只支持本地图片
    4. UILabel无法支持内嵌网络图片(url)，除非自己处理下载逻辑和异步设置逻辑
    ...
 UILabel (BDAsyncAttributedMaker)完美地解决了上面的问题：
    1. 在block块中用maker组装attributedText，同一类逻辑放在代码块中有助于业务写出更内聚的代码
    2. 该用Generator的链式语法设置attributedText属性，解决了代码宽度问题
    3. UILabel支持网络图片，内部实现了异步获取网络图片和设置逻辑
 */
@interface UILabel (BDAsyncAttributedMaker)<BDAttributedContentItemUpdateProtocol>

/**
⭐️ 使用范例：
   [self.shipmentTitleLabel bd_setAsyncAttributedStringWithMaker:^(BDAsyncMutableAttributedStringMaker * _Nonnull m) {
       if ([self.model.overseaIcon isKindOfClass:[NSString class]]) {
           m.webImage(self.model.overseaIcon)
           .size(CGSizeMake(55, 13))
           .alignToFont([UIFont systemFontOfSize:12])
           .verticalAlignment(BDAttributedAttachmentVerticalAlignmentCenter);
           
           m.space(5);
       }
       
       if (self.model.countryIcon) {
           m.webImage(self.model.countryIcon)
           .size(CGSizeMake(15, 15))
           .alignToFont([UIFont systemFontOfSize:12])
           .verticalAlignment(BDAttributedAttachmentVerticalAlignmentCenter);
           
           m.space(4);
       }
       
       m.string(self.model.shipmentDetail).textColor(@"#333333").fontSize(12);
   }];
⭐️ 注意事项：
   网络图片+文字混排的内容使用异步加载方式，如果对同一个Label，既用bd_setAsyncAttributedStringWithMaker设置内容，又直接设置attributedString，可能会因为时序上的错乱而造成意外覆盖，所以需要在设置attributedString前先调用bd_unsetAsyncAttributedString取消订阅，避免意外覆盖。

*/
- (void)bd_setAsyncAttributedStringWithMaker:(void(^)(BDAsyncMutableAttributedStringMaker *m))block;

//取消异步内容更新订阅
- (void)bd_unsetAsyncAttributedString;

@end

NS_ASSUME_NONNULL_END
