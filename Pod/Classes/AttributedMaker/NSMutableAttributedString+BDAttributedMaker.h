//
//  NSMutableAttributedString+BDAttributedMaker.h
//  BDUIKit
//
//  Created by tony zhou on 2019/11/28.
//

#import <Foundation/Foundation.h>
#import "BDAttributedStringGenerator.h"
#import "BDMutableAttributedStringMaker.h"

NS_ASSUME_NONNULL_BEGIN

/**
 NSMutableAttributedString+BDAttributedMaker
 ✨支持用链式语法组装生成复杂的NSMutableAttributedString，缓解开发/维护富文本时产生的焦虑, 使用范例：
    beibiLabel.attributedText = [NSMutableAttributedString bd_makeYYAttributedString:^(BDYYMutableAttributedStringMaker * m) {
        m.yyImage(hb_imageNamed(@"ic_my_money"));
        m.yyImageUrl(@"http://h0.hucdn.com/open201948/ec483a5cabba22f1_72x42.png");
        m.string([NSString stringWithFormat:@"%.02f", beibi]);
        m.yyView(view);
    }];
 */
@interface NSMutableAttributedString (BDAttributedMaker)

/**
 根据block内容自动创建并拼接NSAttributedString片段，拼接顺序和调用顺序一致
 返回拼接完成的字符串，如果没有任何内容，返回一个无内容的NSMutableAttributedString
 
 @Param block 在block中添加代码用BDYYMutableAttributedStringMaker创建NSAttributedString片段
     BDYYMutableAttributedStringMaker支持创建四种类型的NSAttributedString片段，分别是：
     1⃣️ 字符串
        m.string([NSString stringWithFormat:@"%.02f", beibi])
        .textColor(highlightColorString)
        .boldFontSize(20);
        ... 👉更多属性设置方法请参考BDAttributedStringGenerator
     2⃣️ 空白分隔
     3⃣️ 本地图片
        m.yyImage(hb_imageNamed(@"ic_my_money"))
        .contentMode(UIViewContentModeCenter)
        .alignToFont([UIFont systemFontOfSize:20])
        .verticalAlignment(YYTextVerticalAlignmentCenter);
        ... 👉更多属性设置方法请参考BDAttributedAttachmentGenerator
     4⃣️ 网络图片
        m.yyImageUrl(@"http://h0.hucdn.com/open201948/ec483a5cabba22f1_72x42.png")
        .contentMode(UIViewContentModeScaleAspectFit)
        .alignToFont([UIFont systemFontOfSize:20])
        .attachmentSize(CGSizeMake(24, 14))
        .verticalAlignment(YYTextVerticalAlignmentCenter);
        ... 👉更多属性设置方法请参考BDAttributedAttachmentGenerator
     5⃣️ 视图
        m.yyView(({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:hb_imageNamed(@"ic_task_completed") forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, 0, 20, 20);
            [btn bk_addEventHandler:^(id sender) {
                [HBURLHandler openURLString:@"http://m.beidian.com"];
            } forControlEvents:UIControlEventTouchUpInside];
            btn;
        }))
        .contentMode(UIViewContentModeScaleAspectFit)
        .alignToFont([UIFont systemFontOfSize:20])
        .attachmentSize(CGSizeMake(20, 20));
        ... 👉更多属性设置方法请参考BDAttributedAttachmentGenerator
 */
+ (instancetype _Nonnull)bd_makeYYAttributedString:(void(^)(BDYYMutableAttributedStringMaker * m))block;

/**
 系统NSAttributedString（UILabel）版本，仅支持本地图片/文本/空白，如果要内嵌webimage，请使用UILabel+BDAsyncAttributedMaker
 */
+ (instancetype _Nonnull)bd_makeNSAttributedString:(void(^)(BDNSMutableAttributedStringMaker * m))block;

+ (instancetype _Nonnull)bd_makeContent:(void(^)(BDYYMutableAttributedStringMaker * m))block DEPRECATED_MSG_ATTRIBUTE("use bd_makeYYAttributedString/bd_makeNSAttributedString instead");

@end

NS_ASSUME_NONNULL_END
