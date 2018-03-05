//
//  ViewController.m
//  ScrollTapView
//
//  Created by zhenyong on 16/5/2.
//  Copyright © 2016年 com.demo. All rights reserved.
//

#import "ViewController.h"
#import "DTScrollStatusView.h"
@interface ViewController ()<DTScrollStatusDelegate>
///
@property (nonatomic, strong) DTScrollStatusView *scrollTapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"列表";
    _scrollTapView = [[DTScrollStatusView alloc]initWithTitleArr:@[@"工作",
                                                                  @"任务",
                                                                  @"目标"]
                                                           type:ScrollTapTypeWithNavigation];
    _scrollTapView.scrollStatusDelegate = self;
    [self.view addSubview:_scrollTapView];
}
#pragma mark -- DTScrollStatusDelegate
- (void)refreshViewWithTag:(NSInteger)tag
                  isHeader:(BOOL)isHeader {
    if(isHeader)
    {
        NSLog(@"当前%ld个tableview 的头部正在刷新",tag);
    }
    else
    {
        NSLog(@"当前%ld个tableview 的尾部正在刷新",tag);
    }
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    if (tableView.tag == 0) {
        cell.textLabel.text = @"工作";
    }
    else if(tableView.tag == 1)
    {
        cell.textLabel.text = @"任务";
    }
    else
    {
        cell.textLabel.text = @"目标";
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return 1;
    }
    else
    {
        return 2;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
