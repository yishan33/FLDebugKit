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

+ (void)registerWithSection:(NSString *)section block:(FLDebugSectionBlock)block {
    [self registerWithSection:section identifier:[FLDebugManager standardManager].identifier block:block];
}

+ (void)registerWithSection:(NSString *)section identifier:(NSString *)identifier block:(FLDebugSectionBlock)block {
    NSArray *cellItems = block();
    FLDebugManager *manager = [FLDebugManagerFactory managerOfIdentifier:identifier];
    [manager registerSection:section cellItems:cellItems];
}

+ (void)registerAfterLaunch
{
    
}

@end
