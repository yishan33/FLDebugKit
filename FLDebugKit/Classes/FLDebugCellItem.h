//
//  FLDebugCellItem.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import <Foundation/Foundation.h>

@class FLDebugManager;

@interface FLDebugCellItem : NSObject <NSCopying>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign, readonly) BOOL hasAction;

@property (nonatomic, assign, readonly) NSString *tapKeepKey;

@property (nonatomic, weak) FLDebugManager *debugManager;

+ (instancetype)itemWithTitle:(NSString *)title action:(dispatch_block_t)action;

- (void)doAction;

+ (Class)bindCellClass;

+ (NSString *)bindCellReuseIdentifier;

+ (CGFloat)cellHeight;

@end
