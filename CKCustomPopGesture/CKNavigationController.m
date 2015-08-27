//
//  CKNavigationController.m
//  CKCustomPopGesture
//
//  Created by guo on 15/8/27.
//  Copyright (c) 2015年 guo. All rights reserved.
//

#import "CKNavigationController.h"

@interface CKNavigationController ()
<UIGestureRecognizerDelegate>

@end

@implementation CKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 打印系统自带手势
    
    NSLog(@"%@",self.interactivePopGestureRecognizer);
    
    /****打印得到
     <UIScreenEdgePanGestureRecognizer: 0x7fcd134bce20; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fcd13426eb0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fcd134bc6a0>)>>
     *****/
    
    // 2. 分析
    
    /* 系统自带的手势是UIScreenEdgePanGestureRecognizer类型对象,屏幕边缘滑动手势
     * 系统自带手势target是_UINavigationInteractiveTransition类型的对象
     * target调用的action方法名叫handleNavigationTransition:
     * 方法 handleNavigationTransition: 系统已经自实现
     * target 是谁？
     */
    
    // 3. 打印手势的代理对象
    
    NSLog(@"%@",self.interactivePopGestureRecognizer.delegate);
    
    /****打印得到
     <_UINavigationInteractiveTransition: 0x7fcd134bc6a0>
     *****/
    
    // 4. 分析
    
    /* 通过打印系统自带的滑动手势的代理，发现正好是_UINavigationInteractiveTransition对象
     * 只要拿到它，就拿到系统自带滑动手势的target对象
     */
    
    /****************************具体实现如下***************************/
    
    id target = self.interactivePopGestureRecognizer.delegate;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];//handleNavigationTransition:
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    
    // 禁止系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 根控制器不需要触发手势
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
