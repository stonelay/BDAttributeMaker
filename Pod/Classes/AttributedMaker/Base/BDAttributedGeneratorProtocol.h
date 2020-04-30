//
//  BDAttributedGeneratorProtocol.h
//  BDUIKit
//
//  Created by tony zhou on 2019/11/28.
//

#import <Foundation/Foundation.h>
#import "BDAttributedContentItem.h"

@protocol BDAttributedGeneratorProtocol <NSObject>

@required
- (NSAttributedString *_Nullable)generateAttributedString;
- (BDAttributedContentItem *_Nullable)generateAsyncAttributedContent;

@end

