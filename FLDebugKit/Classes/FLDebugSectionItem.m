//
//  FLDebugSectionItem.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import "FLDebugSectionItem.h"
#import "FLDebugCellItem.h"
#import "FLDebugManager.h"

@implementation FLDebugSectionItem

+ (void)registerWithType:(FLDebugSectionType)sectionType block:(FLDebugSectionBlock)block {
    NSArray *cellItems = block();
    [FLDebugManager registerSectionType:sectionType cellItems:cellItems];
}

+ (void)registerAfterLaunch
{
    
}

@end
