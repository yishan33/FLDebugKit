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
    [self registerWithType:sectionType identifier:[FLDebugManager standardManager].identifier block:block];
}

+ (void)registerWithType:(FLDebugSectionType)sectionType identifier:(NSString *)identifier block:(FLDebugSectionBlock)block {
    NSArray *cellItems = block();
    FLDebugManager *manager = [FLDebugManagerFactory managerOfIdentifier:identifier];
    [manager registerSectionType:sectionType cellItems:cellItems];
}

+ (void)registerAfterLaunch
{
    
}

@end
