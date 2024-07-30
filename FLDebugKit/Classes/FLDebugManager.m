//
//  FLDebugManager.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import "FLDebugManager.h"

static NSMapTable *kFLDebugFactoryDict;

static NSString *kFLDebugManagerStandard = @"kFLDebugManagerStandard";

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

@property (nonatomic, strong) NSArray *sections;

@property (nonatomic, strong) NSMutableArray *sectionItems;

@property (nonatomic, strong) NSMutableDictionary *sectionDict;

@end

@implementation FLDebugManager

- (instancetype)initWithIdentifier:(NSString *)identifier sections:(NSArray <NSString *> *)sections
{
    if (self = [super init]) {
        self.identifier = identifier;
        self.maxRecentCount = 3;
        self.sections = sections;
        [FLDebugManagerFactory registerManager:self];
    }
    return self;
}

+ (instancetype)standardManager
{
    static dispatch_once_t onceToken;
    static FLDebugManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[FLDebugManager alloc] initWithIdentifier:kFLDebugManagerStandard sections:@[
            kFLDebugSection_Recent,
            kFLDebugSection_App,
            kFLDebugSection_Net,
            kFLDebugSection_User,
            kFLDebugSection_Device,
            kFLDebugSection_Business,
            kFLDebugSection_Platform,
            kFLDebugSection_Data,
        ]];
    });
    return manager;
}

- (void)registerSection:(NSString *)section cellItems:(NSArray <FLDebugCellItem *> *)cellItems
{
    if (![self.sectionItems containsObject:section]) {
        [self.sectionItems addObject:section];
        [self.sectionDict setObject:cellItems forKey:section];
    } else {
        NSMutableArray *alreadyExistItems = [[self.sectionDict objectForKey:section] mutableCopy];
        
        NSMutableSet *itemTitles = [NSMutableSet set];
        for (FLDebugCellItem *item in alreadyExistItems) {
            [itemTitles addObject:item.title];
        }
        
        // 往section内添加item的同时避免重复添加
        for (FLDebugCellItem *item in cellItems) {
            if (![itemTitles containsObject:item.title]) {
                [alreadyExistItems addObjectsFromArray:cellItems];
                [self.sectionDict setObject:alreadyExistItems forKey:section];
            }
        }
    }
    for (FLDebugCellItem *cellItem in cellItems) {
        cellItem.debugManager = self;
    }
}

- (void)removeItemsFromSection:(NSString *)section andRemoveSection:(BOOL)removeSection
{
    __block NSUInteger removeIndex = NSNotFound;
    [self.sectionItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *sectionStr = (NSString *)obj;
        if ([sectionStr isEqualToString:section]) {
            removeIndex = idx;
            *stop = YES;
        }
    }];
    
    if (removeSection && removeIndex != NSNotFound) {
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
    // 限定只有Standard才能有最近的功能
    if (![self.identifier isEqualToString:kFLDebugManagerStandard]) {
        return;
    }
    
    [self removeItemsFromSection:kFLDebugSection_Recent andRemoveSection:NO];
    
    NSArray *cellTapArray = [[NSUserDefaults standardUserDefaults] objectForKey:self.identifier];
    
    // 先往recentItems中预存sortedKeys.count个item,预留位置
    NSMutableArray *recentItems = [[NSMutableArray alloc] init];
    [cellTapArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [recentItems addObject:[FLDebugCellItem new]];
    }];
    
    for (FLDebugCellItem *item in [self allFlatCellItems]) {
        if ([cellTapArray containsObject:[item tapKeepKey]]) {
            NSUInteger index = [cellTapArray indexOfObject:[item tapKeepKey]];
            [recentItems setObject:item atIndexedSubscript:index];
        }
    }

    [self registerSection:kFLDebugSection_Recent cellItems:[[recentItems reverseObjectEnumerator] allObjects]];
}

#pragma mark - Private

- (void)sortAllSections
{
    [self.sectionItems sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *section1 = (NSString *)obj1;
        NSString *section2 = (NSString *)obj2;
        return [self.sections indexOfObject:section1]  > [self.sections indexOfObject:section2];
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
