//
//  DTScrollStatusView.m

//
//  Created by zhenyong on 16/4/30.
//  Copyright © 2016年 com.lnl. All rights reserved.
//

#import "DTScrollStatusView.h"


@implementation DTScrollStatusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr;
{
    self = [super initWithFrame:frame];
    [self setStatusViewWithTitle:titleArr];
    return self;
}
-(instancetype)initWithTitleArr:(NSArray *)titleArr andType:(ScrollTapType)type
{
    if (type == ScrollTapTypeWithNavigation) {
        self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    }
    else if(type == ScrollTapTypeWithNavigationAndTabbar)
    {
        self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49)];
    }
    else if(type == ScrollTapTypeWithNothing)
    {
        self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    [self setStatusViewWithTitle:titleArr];
    return self;
}
-(instancetype)initWithTitleArr:(NSArray *)titleArr andType:(ScrollTapType)type andNormalTabColor:(UIColor *)normalTabColor andSelectTabColor:(UIColor *)selectTabColor
{
    if (type == ScrollTapTypeWithNavigation) {
        self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    }
    else if(type == ScrollTapTypeWithNavigationAndTabbar)
    {
        self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49)];
    }
    else if(type == ScrollTapTypeWithNothing)
    {
        self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    curNormalTabColor = normalTabColor;
    curSelectTabColor = selectTabColor;
    [self setStatusViewWithTitle:titleArr];
    return self;

}

-(void)setStatusViewWithTitle:(NSArray *)titleArr
{
    float height = self.frame.size.height;
    self.statusView = [[DTStatusView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    self.statusView.delegate = self;
    self.statusView.isScroll = YES;
    if (curNormalTabColor && curSelectTabColor) {
        [self.statusView setUpStatusButtonWithTitlt:titleArr NormalColor:curNormalTabColor SelectedColor:curSelectTabColor LineColor:DTColor(10, 193, 147, 1)];
    }
    else
    {
    [self.statusView setUpStatusButtonWithTitlt:titleArr NormalColor:DTColor(154, 156, 156, 1) SelectedColor:DTColor(10, 193, 147, 1) LineColor:DTColor(10, 193, 147, 1)];
    }
    [self addSubview:self.statusView];
    float y = 45;
    UIView *sessionLine = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, 5)];
    sessionLine.backgroundColor = DTColor(242, 242, 242, 1);
    [self addSubview:sessionLine];
    y+=5;
    //
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, height-y)];
    _mainScrollView.delegate = self;
    _mainScrollView.bounces = NO;
    float mainScrollH = _mainScrollView.frame.size.height;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth*titleArr.count, mainScrollH);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_mainScrollView];
    _tableArr = [NSMutableArray array];
    for ( int i = 0; i < titleArr.count; i++) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, mainScrollH)];
        table.tableFooterView = [[UIView alloc]init];
        table.delegate = self;
        table.dataSource = self;
        table.tag = i+1;
        __weak DTScrollStatusView *weakSelf = self;
        table.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            isrefresh = YES;
            if (_scrollStatusDelegate) {
                
                [weakSelf.scrollStatusDelegate refreshViewWithTag:i+1 andIsHeader:YES];
                [table.mj_header endRefreshing];
                isrefresh = NO;
            }
        }];
        table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            isrefresh = YES;
            if (_scrollStatusDelegate) {
                isrefresh = YES;
                [weakSelf.scrollStatusDelegate refreshViewWithTag:i+1 andIsHeader:NO];
            }
            [table.mj_footer endRefreshing];
            isrefresh = NO;
        }];
        [_tableArr addObject:table];
        [_mainScrollView addSubview:table];
    }
}
#pragma mark--delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_scrollStatusDelegate) {
        if ([_scrollStatusDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            return  [_scrollStatusDelegate numberOfSectionsInTableView:tableView];
            
        }
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   [_scrollStatusDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_scrollStatusDelegate) {
        if ([_scrollStatusDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            return [_scrollStatusDelegate tableView:tableView numberOfRowsInSection:section];
        }
        
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_scrollStatusDelegate) {
        if ([_scrollStatusDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)] ) {
            return [_scrollStatusDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
        }
        
    }
    return 44;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(![scrollView isKindOfClass:[UITableView class]])
    {
    if (isrefresh == NO) {
        int scrollIndex = scrollView.contentOffset.x/kScreenWidth;
        [_statusView changeTag:scrollIndex];
    }
    }
}
- (void)statusViewSelectIndex:(NSInteger)index;
{
    
   [_mainScrollView setContentOffset:CGPointMake(kScreenWidth*index, 0) animated:YES];
}
@end
