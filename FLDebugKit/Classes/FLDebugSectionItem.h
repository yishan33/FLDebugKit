//
//  FLDebugSectionItem.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import <Foundation/Foundation.h>
#import "FLDebugDefine.h"
#import "FLDebugCellItem.h"
#import "FLDebugCellItemText.h"
#import "FLDebugCellItemSwitch.h"

typedef NSArray* (^FLDebugSectionBlock)();

@interface FLDebugSectionItem : NSObject

+ (void)registerWithType:(FLDebugSectionType)sectionType block:(FLDebugSectionBlock)block;

+ (void)registerAfterLaunch;

@end
