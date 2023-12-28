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

- (void)registerSection:(NSString *)section cellItems:(NSArray <FLDebugCellItem *> *)cellItems;

- (void)unRegisterSection:(NSString *)section;

- (NSArray <NSString *> *)allSections;

- (NSArray <NSString *> *)allSectionsWithRecent;

- (NSArray <FLDebugCellItem *> *)allCellItems;

- (NSArray <FLDebugCellItem *> *)cellItemsOfSection:(NSString *)section;

- (void)registerRecentItems;

@end

NS_ASSUME_NONNULL_END
