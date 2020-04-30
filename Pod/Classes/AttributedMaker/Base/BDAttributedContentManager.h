//
//  BDAttributedContentManager.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/6.
//

#import <Foundation/Foundation.h>
#import "BDAttributedContentItem.h"

NS_ASSUME_NONNULL_BEGIN

@class BDAttributedContentManager;

@protocol BDAttributedContentItemUpdateProtocol <NSObject>

@required
- (void)bd_attributedContentManagerDidUpdate:(BDAttributedContentManager *)manager;

@end

@interface BDAttributedContentManager : NSObject

@property (nonatomic, readonly) BOOL isCompleted;

@property (nonatomic, readonly) NSMutableAttributedString *content;


#pragma mark - Update Delegates
- (void)addDelegate:(id<BDAttributedContentItemUpdateProtocol>)delegate;
- (void)removeDelegate:(id<BDAttributedContentItemUpdateProtocol>)delegate;

#pragma mark - Content Management
- (void)addContent:(BDAttributedContentItem *)content;
- (void)asyncMakeContents;

@end

NS_ASSUME_NONNULL_END
