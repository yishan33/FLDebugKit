//
//  FLDebugAlertUtils.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLDebugAlertUtils : NSObject

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                   confirmBlock:(dispatch_block_t)confirmBlock
                    cancelBlock:(dispatch_block_t)cancelBlock;

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                           text:(NSString *)text
                   confirmBlock:(dispatch_block_t)confirmBlock
                    cancelBlock:(dispatch_block_t)cancelBlock;

@end

NS_ASSUME_NONNULL_END
