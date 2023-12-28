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

+ (void)registerWithSection:(NSString *)section block:(FLDebugSectionBlock)block;

+ (void)registerWithSection:(NSString *)section identifier:(NSString *)identifier block:(FLDebugSectionBlock)block;

+ (void)registerAfterLaunch;

@end
