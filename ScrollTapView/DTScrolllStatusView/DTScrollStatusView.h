//
//  DTScrollStatusView.h

//
//  Created by zhenyong on 16/4/30.
//  Copyright © 2016年 com.lnl. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger , ScrollTapType)
{
    ScrollTapTypeWithNavigation,              //含有导航栏
    ScrollTapTypeWithNavigationAndTabbar,     //含有tarbar
    ScrollTapTypeWithNothing,                 //什么都不含有
};
@protocol DTScrollStatusDelegate<UITableViewDelegate,UITableViewDataSource>

- (void)refreshViewWithTag:(NSInteger)tag
                  isHeader:(BOOL)isHeader;

@end
@interface DTScrollStatusView : UIView
/**
 *  含有的tableiview 数组
 */
@property (strong , nonatomic) NSMutableArray *tableArr;

@property (weak , nonatomic) id<DTScrollStatusDelegate> scrollStatusDelegate;
/**
 *  初始化方法，根据不同类型的自动设置frame，类型有是否有导航栏，tarbar，或者两者都没有
 *
 *  @param titleArr 标题数组
 *  @param type     箱式布局类型
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithTitleArr:(NSArray *)titleArr
                            type:(ScrollTapType)type;
/**
 *  初始化方法，根据不同类型的自动设置frame，类型有是否有导航栏，tarbar，或者两者都没有
 *
 *  @param titleArr 标题数组
 *  @param type     箱式布局类型
 *  @param normalTabColor tab 正常的颜色
 *  @param selectTabColor tab 被选中的颜色
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithTitleArr:(NSArray *)titleArr
                            type:(ScrollTapType)type
                  normalTabColor:(UIColor *)normalTabColor
                  selectTabColor:(UIColor *)selectTabColor
                       lineColor:(UIColor *)lineColor;

@end
