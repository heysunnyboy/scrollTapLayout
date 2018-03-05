//
//  DTScrollStatusHeader.h
//  ScrollTapView
//
//  Created by zhenyong on 2018/3/5.
//  Copyright © 2018年 com.demo. All rights reserved.
//

#ifndef DTScrollStatusHeader_h
#define DTScrollStatusHeader_h

#if __OBJC__
#define DTColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
/// 获取屏幕尺寸
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/// 获取iphonex 尺寸
#define IS_IPHONE_X  (kScreenWidth == 375.f && kScreenHeight == 812.f)
#define kStatusBarHeight          [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight             44.0
#define kTabBarHeight             (IS_IPHONE_X ? 83.f : 49.f)
#define kTopHeight                (kStatusBarHeight + kNavBarHeight)
#endif

#endif /* DTScrollStatusHeader_h */
