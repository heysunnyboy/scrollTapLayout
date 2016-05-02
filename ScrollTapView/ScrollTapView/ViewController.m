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
@property (strong , nonatomic) DTScrollStatusView *scrollTapViw;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"列表";
    _scrollTapViw = [[DTScrollStatusView alloc]initWithTitleArr:@[@"工作",@"任务",@"目标"] andType:ScrollTapTypeWithNavigation];
    _scrollTapViw.scrollStatusDelegate = self;
    [self.view addSubview:_scrollTapViw];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark -- delegate
-(void)refreshViewWithTag:(int)tag andIsHeader:(BOOL)isHeader
{
    if(isHeader)
    {
        if(tag == 1)
        {
            UITableView *table = _scrollTapViw.tableArr[tag -1];
            [table reloadData];
        }
        NSLog(@"当前%d个tableview 的头部正在刷新",tag);
    }
    else
    {
        NSLog(@"当前%d个tableview 的尾部正在刷新",tag);
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    if (tableView.tag == 1) {
        cell.textLabel.text = @"工作";
    }
    else if(tableView.tag == 2)
    {
        cell.textLabel.text = @"任务";
    }
    else
    {
        cell.textLabel.text = @"目标";
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
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
