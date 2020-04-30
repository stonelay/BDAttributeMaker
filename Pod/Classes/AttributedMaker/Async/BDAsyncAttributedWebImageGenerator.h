//
//  BDAsyncAttributedWebImageGenerator.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "BDAttributedAttachmentGenerator.h"

@interface BDAttributedAttachmentGenerator(Placeholder)

@property (nonatomic, copy, readonly) BDAttributedAttachmentGenerator *(^placeholder)(UIImage *);

@end

@interface BDAsyncAttributedWebImageGenerator : BDAttributedAttachmentGenerator

- (instancetype)initWithImageUrl:(id<HBURLConvertible>)url;

@end
