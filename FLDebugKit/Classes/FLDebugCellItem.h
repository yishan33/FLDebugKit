//
//  FLDebugCellItem.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import <Foundation/Foundation.h>

extern NSString * const kFLDebugCellTapArrayKey;

@interface FLDebugCellItem : NSObject <NSCopying>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign, readonly) BOOL hasAction;

@property (nonatomic, assign, readonly) NSString *tapKeepKey;

+ (instancetype)itemWithTitle:(NSString *)title action:(dispatch_block_t)action;

- (void)doAction;

+ (Class)bindCellClass;

+ (NSString *)bindCellReuseIdentifier;

+ (CGFloat)cellHeight;

@end
