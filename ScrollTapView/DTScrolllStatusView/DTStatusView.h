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

- (void)statusViewSelectIndex:(NSInteger)index;

@end


@interface DTStatusView : UIView

@property (nonatomic,strong)NSMutableArray *buttonArray;

@property (nonatomic,assign) id <DTStatusViewDelegate>delegate;

//横线
@property (nonatomic,strong) UIView *lineView;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) BOOL isScroll;
//界面书初始化 titleArray状态值,normalColor正常标题颜色，selectedColor选中的颜色，lineColor下面线条颜色如果等于nil就没有线条
- (void)setUpStatusButtonWithTitlt:(NSArray *)titleArray NormalColor:(UIColor *)normalColor SelectedColor:(UIColor *)selectedColor LineColor:(UIColor *)lineColor;

-(void)changeTag:(int)tag;


@end
