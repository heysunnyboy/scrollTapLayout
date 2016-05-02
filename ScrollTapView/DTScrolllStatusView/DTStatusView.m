//
//  BSOrderStatusView.m
//  BuyAndSend
//
//  Created by  on 16/3/24.
//  Copyright © 2016年 mjia. All rights reserved.
//

#import "DTStatusView.h"

@implementation DTStatusView

//界面搭建
- (void)setUpStatusButtonWithTitlt:(NSArray *)titleArray NormalColor:(UIColor *)normalColor SelectedColor:(UIColor *)selectedColor LineColor:(UIColor *)lineColor{
    
    //按钮创建
    float width = self.frame.size.width/titleArray.count;
    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, 0, width, self.frame.size.height);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:(normalColor)?normalColor:[UIColor colorWithRed:139/255.0 green:141/255.0 blue:141/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button addTarget:self action:@selector(buttonTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
        
        if (i == 0) {
            button.selected = YES;
        }
    }
    self.currentIndex = 0;
    
    //线条
    if (lineColor) {
        
        self.lineView.frame = CGRectMake(0, self.frame.size.height-2, width, 2);
        self.lineView.backgroundColor = lineColor;
    }
    
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

#pragma 懒加载
- (NSMutableArray *)buttonArray{
    
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    
    return _buttonArray;
}
-(void)changeTag:(int)tag
{
    //选择当前的状态
    self.currentIndex = tag;
    UIButton *button = self.buttonArray[tag];
    button.selected = YES;
    
    //关闭上一个选择状态
    for (int i = 0; i < self.buttonArray.count; i++) {
        if (i != self.currentIndex) {
            
            UIButton *button = self.buttonArray[i];
            button.selected = NO;
        }
    }
    
    //移动横线到对应的状态
    if (self.lineView) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect frame = self.lineView.frame;
            float origin = self.frame.size.width/self.buttonArray.count*tag;
            frame.origin.x = origin;
            self.lineView.frame = frame;
        }];
    }
    
  
}
//下面滑动的横线
- (UIView *)lineView{

    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        [self addSubview:self.lineView];
    }
    return _lineView;
}

@end
