//
//  ViewController.m
//  PageViewDemo
//
//  Created by ramborange on 2019/1/21.
//  Copyright © 2019 ramborange. All rights reserved.
//

#import "ViewController.h"
#import "CMPageScrollViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //试试创建1000个controller,滑动查看内存变化
    NSArray *titleArray = @[@"关注",@"推荐",@"热点",@"视频",@"上海",@"科技",@"国际",@"财经",@"体育",@"汽车"];
    NSArray *viewControllers = @[[TestViewController new],[TestViewController new],[TestViewController new],[TestViewController new],[TestViewController new],[TestViewController new],[TestViewController new],[TestViewController new],[TestViewController new],[TestViewController new]];
    
    
    CMPageScrollViewController *pagevc = [[CMPageScrollViewController alloc] initWithHeaderStyle:[CMPageHeaderStyle styleWithTitleArray:titleArray controllerArray:viewControllers headerBarColor:[UIColor lightGrayColor] titleFont:[UIFont systemFontOfSize:18] textNormalColor:[UIColor blackColor] textSelectedColor:[UIColor redColor] headerViewHeight:50 headerButtonMargin:15.0 indicatorColor:[UIColor orangeColor] headerViewAligment:HeaderPageScrollAlignmentLeft] headerFrame:CGRectMake(0, 40, self.view.bounds.size.width, 50)];
    
    //用法1：添加到当前控制器
    [self.view addSubview:pagevc.view];
    [self addChildViewController:pagevc];
    
    //用法2：从当前控制器 present 或 push 过去
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self presentViewController:pagevc animated:YES completion:NULL];
//    });
    
    //用法3：作为tabBarController导航栏根视图控制器
//    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:pagevc];
//    tabarController.viewControllers = @[homeNav,...];
    
}


@end
