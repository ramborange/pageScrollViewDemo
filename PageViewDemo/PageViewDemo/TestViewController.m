//
//  TestViewController.m
//  PageViewDemo
//
//  Created by ramborange on 2019/1/22.
//  Copyright © 2019 ramborange. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self ramdomColor];
}
- (UIColor *)ramdomColor {
    return [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0  blue:(arc4random()%255)/255.0  alpha:1.0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
