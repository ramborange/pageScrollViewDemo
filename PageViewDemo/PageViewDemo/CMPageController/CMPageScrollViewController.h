//
//  CMPageScrollViewController.h
//  PageViewDemo
//
//  Created by ramborange on 2019/1/21.
//  Copyright © 2019 ramborange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPageHeaderStyle.h"

@interface CMPageScrollViewController : UIViewController

/**
 创建一个滚动的视图控制器

 @param style 滚动视图控制器样式及数据
 @param headerFrame 顶部滚动菜单视图frame
 */
- (CMPageScrollViewController *)initWithHeaderStyle:(CMPageHeaderStyle *)style
                                        headerFrame:(CGRect)headerFrame;

@end

