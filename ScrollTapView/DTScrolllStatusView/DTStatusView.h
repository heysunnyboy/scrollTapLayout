//
//  BSOrderStatusView.h
//  BuyAndSend
//
//  Created by  on 16/3/24.
//  Copyright © 2016年 mjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DTColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@protocol DTStatusViewDelegate <NSObject>
/// 选中某个tab
- (void)statusViewSelectIndex:(NSInteger)index;
@end

@interface DTStatusView : UIView
/// 是否正在滑动
@property (nonatomic, assign) BOOL isScroll;
/// 代理
@property (nonatomic, weak) id <DTStatusViewDelegate>delegate;
/// 界面初始化
- (void)setUpStatusButtonWithTitle:(NSArray *)titleArray
                       normalColor:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                         lineColor:(UIColor *)lineColor;
/// 切换tag
-(void)changeTag:(NSInteger)tag;


@end
