//
//  FLDebugManager.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import "FLDebugManager.h"

static NSMapTable *kFLDebugFactoryDict;

@implementation FLDebugManagerFactory

+ (void)registerManager:(FLDebugManager *)manager
{
    if (!kFLDebugFactoryDict) {
        kFLDebugFactoryDict = [NSMapTable strongToWeakObjectsMapTable];
    }
    [kFLDebugFactoryDict setObject:manager forKey:manager.identifier];
}

+ (FLDebugManager *)managerOfIdentifier:(NSString *)identifier
{
    if (!kFLDebugFactoryDict) {
        kFLDebugFactoryDict = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    return [kFLDebugFactoryDict objectForKey:identifier];
}

@end

@interface FLDebugManager ()

@property (nonatomic, copy, readwrite) NSString *identifier;

@property (nonatomic, strong) NSMutableArray *sectionItems;

@property (nonatomic, strong) NSMutableDictionary *sectionDict;

@end

@implementation FLDebugManager

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        self.identifier = identifier;
        self.maxRecentCount = 3;
        [FLDebugManagerFactory registerManager:self];
    }
    return self;
}

+ (instancetype)standardManager
{
    static dispatch_once_t onceToken;
    static FLDebugManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[FLDebugManager alloc] initWithIdentifier:@"Standard"];
    });
    return manager;
}

- (void)registerSectionType:(FLDebugSectionType)sectionType cellItems:(NSArray <FLDebugCellItem *> *)cellItems
{
    if (![self.sectionItems containsObject:@(sectionType)]) {
        [self.sectionItems addObject:@(sectionType)];
        [self.sectionDict setObject:cellItems forKey:@(sectionType)];
    } else {
        NSMutableArray *targetArray = [[self.sectionDict objectForKey:@(sectionType)] mutableCopy];
        [targetArray addObjectsFromArray:cellItems];
        [self.sectionDict setObject:targetArray forKey:@(sectionType)];
    }
    for (FLDebugCellItem *cellItem in cellItems) {
        cellItem.debugManager = self;
    }
}

- (void)unRegisterSectionType:(FLDebugSectionType)sectionType
{
    __block NSUInteger removeIndex = NSNotFound;
    [self.sectionItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *sectionTypeNum = (NSNumber *)obj;
        if ([sectionTypeNum unsignedIntegerValue] == sectionType) {
            removeIndex = idx;
            *stop = YES;
        }
    }];
    if (removeIndex != NSNotFound) {
        [self.sectionItems removeObjectAtIndex:removeIndex];
    }
}

- (NSArray <NSNumber *> *)allSectionTypes
{
    [self.sectionItems sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *section1 = (NSNumber *)obj1;
        NSNumber *section2 = (NSNumber *)obj2;
        return [section1 unsignedIntegerValue]  > [section2 unsignedIntegerValue];
    }];
    
    return [self.sectionItems copy];
}

- (NSArray <NSNumber *> *)allSectionTypesWithRecent
{
    [self registerRecentItems];
    return [self allSectionTypes];
}

- (NSArray <FLDebugCellItem *> *)allCellItems
{
    [self.sectionItems sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *section1 = (NSNumber *)obj1;
        NSNumber *section2 = (NSNumber *)obj2;
        return [section1 unsignedIntegerValue]  > [section2 unsignedIntegerValue];
    }];
    
    NSMutableArray *cellItems = [[NSMutableArray alloc] init];
    for (NSNumber *sectionNum in self.sectionItems) {
        NSArray *items = [self cellItemsOfSection:[sectionNum unsignedIntegerValue]];
        [cellItems addObjectsFromArray:items];
    }
    
    return [cellItems copy];
}

- (NSArray <FLDebugCellItem *> *)cellItemsOfSection:(FLDebugSectionType)sectionType
{
    return [self.sectionDict objectForKey:@(sectionType)];
}

- (void)registerRecentItems
{
    [self unRegisterSectionType:FLDebugSectionType_Recent];
    
    NSArray *cellTapArray = [[NSUserDefaults standardUserDefaults] objectForKey:self.identifier];
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

    [[FLDebugManager standardManager] registerSectionType:FLDebugSectionType_Recent cellItems:[[recentItems reverseObjectEnumerator] allObjects]];
}

#pragma mark - Getter

- (NSMutableArray *)sectionItems
{
    if (!_sectionItems) {
        _sectionItems = [[NSMutableArray alloc] init];
    }
    return _sectionItems;
}

- (NSMutableDictionary *)sectionDict
{
    if (!_sectionDict) {
        _sectionDict = [[NSMutableDictionary alloc] init];
    }
    return _sectionDict;
}

@end
