//
//  UIView+FLDebug.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FLDebug)

@property (nonatomic, assign) CGFloat fl_x;

@property (nonatomic, assign) CGFloat fl_y;

@property (nonatomic, assign) CGFloat fl_width;

@property (nonatomic, assign) CGFloat fl_height;

@property (nonatomic, assign) CGPoint fl_origin;

@property (nonatomic, assign) CGSize fl_size;

@property (nonatomic, assign) CGFloat fl_bottom;

@property (nonatomic, assign) CGFloat fl_right;

@property (nonatomic, assign) CGFloat fl_left;

@property (nonatomic, assign) CGFloat fl_top;

@property (nonatomic, assign) CGFloat fl_centerX;

@property (nonatomic, assign) CGFloat fl_centerY;

@end

NS_ASSUME_NONNULL_END
