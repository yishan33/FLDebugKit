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

- (void)registerSection:(NSString *)section cellItems:(NSArray <FLDebugCellItem *> *)cellItems
{
    if (![self.sectionItems containsObject:section]) {
        [self.sectionItems addObject:section];
        [self.sectionDict setObject:cellItems forKey:section];
    } else {
        NSMutableArray *targetArray = [[self.sectionDict objectForKey:section] mutableCopy];
        [targetArray addObjectsFromArray:cellItems];
        [self.sectionDict setObject:targetArray forKey:section];
    }
    for (FLDebugCellItem *cellItem in cellItems) {
        cellItem.debugManager = self;
    }
}

- (void)unRegisterSection:(NSString *)section
{
    __block NSUInteger removeIndex = NSNotFound;
    [self.sectionItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *sectionStr = (NSString *)obj;
        if ([sectionStr isEqualToString:section]) {
            removeIndex = idx;
            *stop = YES;
        }
    }];
    if (removeIndex != NSNotFound) {
        [self.sectionItems removeObjectAtIndex:removeIndex];
    }
}

- (NSArray <NSString *> *)allSections
{
    [self sortAllSections];
    return [self.sectionItems copy];
}

- (NSArray <NSString *> *)allSectionsWithRecent
{
    [self registerRecentItems];
    return [self allSections];
}

- (NSArray < NSArray <FLDebugCellItem *> *> *)allCellItems
{
    NSMutableArray *cellItems = [[NSMutableArray alloc] init];
    for (NSString *section in self.sectionItems) {
        NSArray *items = [self cellItemsOfSection:section];
        [cellItems addObject:items];
    }
    
    return [cellItems copy];
}

- (NSArray <FLDebugCellItem *> *)allFlatCellItems;
{
    [self sortAllSections];
    NSMutableArray *cellItems = [[NSMutableArray alloc] init];
    for (NSString *section in self.sectionItems) {
        NSArray *items = [self cellItemsOfSection:section];
        [cellItems addObjectsFromArray:items];
    }
    
    return [cellItems copy];
}

- (NSArray <FLDebugCellItem *> *)cellItemsOfSection:(NSString *)section
{
    return [self.sectionDict objectForKey:section];
}

- (void)registerRecentItems
{
    [self unRegisterSection:kFLDebugSection_Recent];
    
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

    [[FLDebugManager standardManager] registerSection:kFLDebugSection_Recent cellItems:[[recentItems reverseObjectEnumerator] allObjects]];
}

#pragma mark - Private

- (void)sortAllSections
{
    [self.sectionItems sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *section1 = (NSString *)obj1;
        NSString *section2 = (NSString *)obj2;
        return [self.sectionItems indexOfObject:section1]  > [self.sectionItems indexOfObject:section2];
    }];
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
