//
//  UIView+FLDebug.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/29.
//

#import "UIView+FLDebug.h"

#define fl_ScreenScale ([UIScreen mainScreen].scale)
#define fl_PIXEL_INTEGRAL(pointValue) (round(pointValue * fl_ScreenScale) / fl_ScreenScale)

@implementation UIView (FLDebug)

- (void)setFl_x:(CGFloat)fl_x
{
    self.frame = CGRectMake(fl_PIXEL_INTEGRAL(fl_x), self.fl_y, self.fl_width, self.fl_height);
}

- (void)setFl_y:(CGFloat)fl_y
{
    self.frame = CGRectMake(self.fl_x, fl_PIXEL_INTEGRAL(fl_y), self.fl_width, self.fl_height);
}

- (void)setFl_width:(CGFloat)fl_width
{
    self.frame = CGRectMake(self.fl_x, self.fl_y, fl_PIXEL_INTEGRAL(fl_width), self.fl_height);
}

- (void)setFl_height:(CGFloat)fl_height
{
    self.frame = CGRectMake(self.fl_x, self.fl_y, self.fl_width, fl_PIXEL_INTEGRAL(fl_height));
}

- (void)setFl_origin:(CGPoint)fl_origin
{
    self.fl_x = fl_origin.x;
    self.fl_y = fl_origin.y;
}

- (void)setFl_size:(CGSize)fl_size
{
    self.fl_width = fl_size.width;
    self.fl_height = fl_size.height;
}

- (void)setFl_bottom:(CGFloat)fl_bottom
{
    self.fl_y = fl_bottom - self.fl_height;
}

- (void)setFl_right:(CGFloat)fl_right
{
    self.fl_x = fl_right - self.fl_width;
}

- (void)setFl_left:(CGFloat)fl_left
{
    self.fl_x = fl_left;
}

- (void)setFl_top:(CGFloat)fl_top
{
    self.fl_y = fl_top;
}

- (void)setFl_centerX:(CGFloat)fl_centerX
{
    self.center = CGPointMake(fl_PIXEL_INTEGRAL(fl_centerX), self.fl_centerY);
}

- (void)setFl_centerY:(CGFloat)fl_centerY
{
    self.center = CGPointMake(self.fl_centerX, fl_PIXEL_INTEGRAL(fl_centerY));
}

- (CGFloat)fl_x
{
    return self.frame.origin.x;
}

- (CGFloat)fl_y
{
    return self.frame.origin.y;
}

- (CGFloat)fl_width
{
    return self.frame.size.width;
}

- (CGFloat)fl_height
{
    return self.frame.size.height;
}

- (CGPoint)fl_origin
{
    return self.frame.origin;
}

- (CGSize)fl_size
{
    return self.frame.size;
}

- (CGFloat)fl_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)fl_right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)fl_left
{
    return self.frame.origin.x;
}

- (CGFloat)fl_top
{
    return self.frame.origin.y;
}

- (CGFloat)fl_centerX
{
    return self.center.x;
}

- (CGFloat)fl_centerY
{
    return self.center.y;
}

@end
