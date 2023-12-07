//
//  FLDebugManager.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import "FLDebugManager.h"

static NSMutableArray *kFLDebugSectionItems;
static NSMutableDictionary *kFLDebugSectionDict;

@implementation FLDebugManager

+ (void)registerSectionType:(FLDebugSectionType)sectionType cellItems:(NSArray <FLDebugCellItem *> *)cellItems
{
    if (!kFLDebugSectionItems) {
        kFLDebugSectionItems = [[NSMutableArray alloc] init];
    }
    if (!kFLDebugSectionDict) {
        kFLDebugSectionDict = [[NSMutableDictionary alloc] init];
    }
    
    if (![kFLDebugSectionItems containsObject:@(sectionType)]) {
        [kFLDebugSectionItems addObject:@(sectionType)];
        [kFLDebugSectionDict setObject:cellItems forKey:@(sectionType)];
    } else {
        NSMutableArray *targetArray = [[kFLDebugSectionDict objectForKey:@(sectionType)] mutableCopy];
        [targetArray addObjectsFromArray:cellItems];
        [kFLDebugSectionDict setObject:targetArray forKey:@(sectionType)];
    }
}

+ (void)unRegisterSectionType:(FLDebugSectionType)sectionType
{
    __block NSUInteger removeIndex = NSNotFound;
    [kFLDebugSectionItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *sectionTypeNum = (NSNumber *)obj;
        if ([sectionTypeNum unsignedIntegerValue] == sectionType) {
            removeIndex = idx;
            *stop = YES;
        }
    }];
    if (removeIndex != NSNotFound) {
        [kFLDebugSectionItems removeObjectAtIndex:removeIndex];
    }
}

+ (NSArray <NSNumber *> *)allSectionTypes
{
    [kFLDebugSectionItems sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *section1 = (NSNumber *)obj1;
        NSNumber *section2 = (NSNumber *)obj2;
        return [section1 unsignedIntegerValue]  > [section2 unsignedIntegerValue];
    }];
    
    return [kFLDebugSectionItems copy];
}

+ (NSArray <FLDebugSectionItem *> *)allCellItems
{
    [kFLDebugSectionItems sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *section1 = (NSNumber *)obj1;
        NSNumber *section2 = (NSNumber *)obj2;
        return [section1 unsignedIntegerValue]  > [section2 unsignedIntegerValue];
    }];
    
    NSMutableArray *cellItems = [[NSMutableArray alloc] init];
    for (NSNumber *sectionNum in kFLDebugSectionItems) {
        NSArray *items = [self cellItemsOfSection:[sectionNum unsignedIntegerValue]];
        [cellItems addObjectsFromArray:items];
    }
    
    return [cellItems copy];
}

+ (NSArray <FLDebugCellItem *> *)cellItemsOfSection:(FLDebugSectionType)sectionType
{
    return [kFLDebugSectionDict objectForKey:@(sectionType)];
}

// 注册最近使用模块
+ (void)registerRecentItems
{
    [self unRegisterSectionType:FLDebugSectionType_Recent];
    
    NSArray *cellTapArray = [[NSUserDefaults standardUserDefaults] objectForKey:kFLDebugCellTapArrayKey];
    // 先往recentItems中预存sortedKeys.count个item,预留位置
    NSMutableArray *recentItems = [[NSMutableArray alloc] init];
    [cellTapArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [recentItems addObject:[FLDebugCellItem new]];
    }];
    for (FLDebugCellItem *item in [self allCellItems]) {
        if ([cellTapArray containsObject:[item tapKeepKey]]) {
            NSUInteger index = [cellTapArray indexOfObject:[item tapKeepKey]];
            [recentItems setObject:[item copy] atIndexedSubscript:index];
        }
    }

    [FLDebugManager registerSectionType:FLDebugSectionType_Recent cellItems:[[recentItems reverseObjectEnumerator] allObjects]];
}


@end
