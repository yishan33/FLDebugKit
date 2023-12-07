//
//  FLDebugAlertUtils.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import "FLDebugAlertUtils.h"

@implementation FLDebugAlertUtils

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                   confirmBlock:(dispatch_block_t)confirmBlock
                    cancelBlock:(dispatch_block_t)cancelBlock
{
    [self handleAlertActionWithVC:vc text:@"该功能需要重启方可生效" confirmBlock:confirmBlock cancelBlock:cancelBlock];
}

+ (void)handleAlertActionWithVC:(UIViewController *)vc
                           text:(NSString *)text
                   confirmBlock:(dispatch_block_t)confirmBlock
                    cancelBlock:(dispatch_block_t)cancelBlock
{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirmBlock) {
            confirmBlock();
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    if (confirmBlock) {
        [alertControl addAction:cancelAction];
    }
    if (cancelBlock) {
        [alertControl addAction:confirmAction];
    }
    if (alertControl.actions.count == 0) {
        [alertControl addAction:defaultAction];
    }
    
    [vc presentViewController:alertControl animated:YES completion:nil];
}

@end
