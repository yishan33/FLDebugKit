//
//  FLDebugManager.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import <Foundation/Foundation.h>
#import "FLDebugSectionItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface FLDebugManager : NSObject

+ (void)registerSectionType:(FLDebugSectionType)sectionType cellItems:(NSArray <FLDebugCellItem *> *)cellItems;

+ (void)unRegisterSectionType:(FLDebugSectionType)sectionType;

+ (NSArray <NSNumber *> *)allSectionTypes;

+ (NSArray <FLDebugCellItem *> *)allCellItems;

+ (NSArray <FLDebugCellItem *> *)cellItemsOfSection:(FLDebugSectionType)sectionType;

+ (void)registerRecentItems;

@end

NS_ASSUME_NONNULL_END
