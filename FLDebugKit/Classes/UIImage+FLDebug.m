//
//  UIImage+FLDebug.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import "UIImage+FLDebug.h"

@implementation UIImage (FLDebug)

+ (UIImage *)fl_imageNamed:(NSString *)name
{
    if(name) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"FLDebugManager")];
        NSURL *url = [bundle URLForResource:@"FLDebugKit" withExtension:@"bundle"];
        NSBundle *imageBundle = nil;
        if (url) {
            imageBundle = [NSBundle bundleWithURL:url];
        }
        
        NSString *imageName = nil;
        CGFloat scale = [UIScreen mainScreen].scale;
        if (ABS(scale-3) <= 0.001){
            imageName = [NSString stringWithFormat:@"%@@3x",name];
        }else if(ABS(scale-2) <= 0.001){
            imageName = [NSString stringWithFormat:@"%@@2x",name];
        }else{
            imageName = name;
        }
        UIImage *image = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:imageName ofType:@"png"]];
        if (!image) {
            image = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:name ofType:@"png"]];
            if (!image) {
                image = [UIImage imageNamed:name];
            }
        }
        return image;
    }
    
    return nil;
}

@end
