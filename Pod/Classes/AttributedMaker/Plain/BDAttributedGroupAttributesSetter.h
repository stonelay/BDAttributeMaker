//
//  BDAttributedGroupAttributesSetter.h
//  BDUIKit
//
//  Created by tony zhou on 2019/12/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDAttributedGroupAttributesSetter : NSObject

@property (nonatomic, copy, readonly) BDAttributedGroupAttributesSetter *(^setAttribute)(NSAttributedStringKey,id);

@property (nonatomic, copy, readonly) NSDictionary<NSAttributedStringKey, id> *attributes;

@end

NS_ASSUME_NONNULL_END
