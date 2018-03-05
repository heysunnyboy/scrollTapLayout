//
//  BSOrderStatusView.m
//  BuyAndSend
//
//  Created by  on 16/3/24.
//  Copyright © 2016年 mjia. All rights reserved.
//

#import "DTStatusView.h"
@interface DTStatusView()
@property (nonatomic, strong)NSMutableArray *buttonArray;
/// 横线
@property (nonatomic, strong) UIView *lineView;
/// 当前索引
@property (nonatomic, assign) NSInteger currentIndex;

@end
@implementation DTStatusView
#pragma mark - private function
- (void)setUpStatusButtonWithTitle:(NSArray *)titleArray
                       normalColor:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                         lineColor:(UIColor *)lineColor{
    
    //按钮创建
    NSInteger count = titleArray.count;
    float     width = self.frame.size.width / count;
    for (int i = 0; i < count; i++) {
        UIButton *button = [self createButtonByIndex:i normalColor:normalColor selectedColor:selectedColor];
        button.frame     = CGRectMake(width * i,
                                  0,
                                  width,
                                  self.frame.size.height);
        /// 标题
        [button setTitle:titleArray[i]
                forState:UIControlStateNormal];

        
    }
    self.currentIndex = 0;
    //线条
    if (lineColor) {
        self.lineView.frame = CGRectMake(0, self.frame.size.height-2, width, 2);
        self.lineView.backgroundColor = lineColor;
    }
}
/// 创建button
- (UIButton *)createButtonByIndex:(NSInteger)index
                normalColor:(UIColor *)normalColor
              selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:(normalColor) ? normalColor: DTColor(139, 141, 141, 1) forState:UIControlStateNormal];
    [button setTitleColor:selectedColor
                 forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    /// 点击
    button.tag = index;
    [button addTarget:self action:@selector(buttonTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttonArray addObject:button];
    /// 第一个默认选中
    if (index == 0) {
        button.selected = YES;
    }
    return button;
}

//状态切换
- (void)buttonTouchEvent:(UIButton *)button{
    if (button.tag == self.currentIndex) {
        return;
    }
    //代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(statusViewSelectIndex:)]) {
        
        [self.delegate statusViewSelectIndex:button.tag];
    }
    if (!_isScroll) {
        [self changeTag:button.tag];
    }
}
-(void)changeTag:(NSInteger)tag
{
    // 选择当前的状态
    self.currentIndex = tag;
    UIButton *button  = self.buttonArray[tag];
    button.selected   = YES;
    // 关闭上一个选择状态
    for (int i = 0; i < self.buttonArray.count; i++) {
        if (i != self.currentIndex) {
            
            UIButton *button = self.buttonArray[i];
            button.selected = NO;
        }
    }
    // 移动横线到对应的状态
    if (self.lineView) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.lineView.frame;
            float origin = self.frame.size.width / self.buttonArray.count*tag;
            frame.origin.x      = origin;
            self.lineView.frame = frame;
        }];
    }
}
#pragma mark - 懒加载
- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

//下面滑动的横线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
    }
    return _lineView;
}

@end
