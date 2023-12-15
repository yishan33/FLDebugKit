//
//  FLDebugManager.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import <Foundation/Foundation.h>
#import "FLDebugSectionItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLDebugManagerFactory : NSObject

+ (FLDebugManager *)managerOfIdentifier:(NSString *)identifier;

@end

@interface FLDebugManager : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, assign) NSUInteger maxRecentCount;

- (instancetype)initWithIdentifier:(NSString *)identifier;

+ (instancetype)standardManager;

- (void)registerSectionType:(FLDebugSectionType)sectionType cellItems:(NSArray <FLDebugCellItem *> *)cellItems;

- (void)unRegisterSectionType:(FLDebugSectionType)sectionType;

- (NSArray <NSNumber *> *)allSectionTypes;

- (NSArray <NSNumber *> *)allSectionTypesWithRecent;

- (NSArray <FLDebugCellItem *> *)allCellItems;

- (NSArray <FLDebugCellItem *> *)cellItemsOfSection:(FLDebugSectionType)sectionType;

- (void)registerRecentItems;

@end

NS_ASSUME_NONNULL_END
