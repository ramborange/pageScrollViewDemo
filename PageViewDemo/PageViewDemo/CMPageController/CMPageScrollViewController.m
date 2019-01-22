//
//  CMPageScrollViewController.m
//  PageViewDemo
//
//  Created by ramborange on 2019/1/21.
//  Copyright © 2019 ramborange. All rights reserved.
//

#import "CMPageScrollViewController.h"
#import "CMPageScrollHeader.h"

@interface CMPageScrollViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

/**
 滚动视图的样式
 */
@property (nonatomic, strong) CMPageHeaderStyle *headerStyle;

/**
 顶部滚动视图
 */
@property (nonatomic, strong) CMPageScrollHeader *pageScrollHeaderview;

/**
 当前显示的视图控制器的index
 */
@property (nonatomic, assign) NSInteger pageIndex;

/**
 滚动视图控制器
 */
@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation CMPageScrollViewController
- (void)dealloc {
    _headerStyle = nil;
    _pageScrollHeaderview = nil;
    _pageViewController.delegate = nil;
    _pageViewController.dataSource = nil;
    _pageViewController = nil;

}

- (CMPageScrollViewController *)initWithHeaderStyle:(CMPageHeaderStyle *)style
                                        headerFrame:(CGRect)headerFrame {
    
    CMPageScrollViewController *retVc = [CMPageScrollViewController new];
    retVc.headerStyle = style;
    retVc.pageIndex = 0;
    
    //顶部滚动菜单视图配置
    retVc.pageScrollHeaderview = [[CMPageScrollHeader alloc] initWithTitleArray:style.titlesArray frame:headerFrame style:style];
    __weak __typeof(retVc)weakself = retVc;
    retVc.pageScrollHeaderview.headerSelectHandler = ^(NSInteger selecedIdx) {
        //顶部滚动视图按钮点击回调事件
        UIViewController *vc = [weakself.headerStyle.controllersArray objectAtIndex:selecedIdx];
        if (selecedIdx > weakself.pageIndex) {
            [weakself.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            }];
        } else {
            [weakself.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
                
            }];
        }
        weakself.pageIndex = selecedIdx;
    };
    [retVc.view addSubview:retVc.pageScrollHeaderview];

    //初始化子视图UI
    [retVc initSubviews];
    
    return retVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 初始化子视图UI
- (void)initSubviews{
    self.pageIndex = 0;// UIPageViewController控制器里的当前VC下标
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    // UIPageViewControllerDelegate,UIPageViewControllerDataSource
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;

    [self.pageViewController setViewControllers:@[[self.headerStyle.controllersArray firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    CGFloat orign_y = CGRectGetMaxY(self.pageScrollHeaderview.frame);
    self.pageViewController.view.frame = CGRectMake(0, orign_y, self.view.bounds.size.width, self.view.bounds.size.height-orign_y);
    
}


#pragma mark -- UIPageViewControllerDataSource
// 向后滑
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger index = [self.headerStyle.controllersArray indexOfObject:viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self.headerStyle.controllersArray objectAtIndex:index];
}
// 向前滑
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index = [self.headerStyle.controllersArray indexOfObject:viewController];
    if (index == self.headerStyle.controllersArray.count - 1 || (index == NSNotFound)) {
        return nil;
    }
    index++;
    return [self.headerStyle.controllersArray objectAtIndex:index];
    
}


#pragma mark -- UIPageViewControllerDelegate
// 将要滑动
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [self.headerStyle.controllersArray indexOfObject:nextVC];
    self.pageIndex = index;
}
// 结束滑动
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        [self.pageScrollHeaderview slideHeadWithIndex:self.pageIndex];
    }
}


@end
