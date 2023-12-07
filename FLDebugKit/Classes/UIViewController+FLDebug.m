//
//  UIViewController+FLDebug.m
//  FLDebugKit
//
//  Created by forthonliu on 2023/12/7.
//

#import "UIViewController+FLDebug.h"

@implementation UIViewController (FLDebug)

// 获取TopViewController http://www.manongjc.com/detail/50-krtqrptqatfdjzg.html
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
