//
//  CMPageScrollHeader.h
//  PageViewDemo
//
//  Created by ramborange on 2019/1/21.
//  Copyright © 2019 ramborange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageHeaderStyle.h"

@interface CMPageScrollHeader : UIScrollView

/**
 顶部滑动条按钮的点击事件回调（请在自定的控制器内自行接收，单独作为视图来用时）
 */
@property (nonatomic, copy) void(^headerSelectHandler)(NSInteger selecedIdx); 


/**
 初始化方法

 @param titleArray 标题数组
 @param frame 滚动视图的frame
 @param headerStyle 滑动视图样式
 
 @return 返回顶部滑动菜单视图
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArray
                             frame:(CGRect)frame
                             style:(CMPageHeaderStyle *)headerStyle;



/**
 滑动page，head滑动

 @param index 当前需要滑动到的index
 */
- (void)slideHeadWithIndex:(NSInteger)index;

@end
