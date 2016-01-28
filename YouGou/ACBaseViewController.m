//
//  ACBaseViewController.m
//  ArtCMP
//
//  Created by jin on 15/6/23.
//  Copyright (c) 2015年 Art. All rights reserved.
//

#import "ACBaseViewController.h"

@interface ACBaseViewController ()

@property (strong,nonatomic) UIButton *btnBack;

@end

@implementation ACBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureView];
    [self configureNavigationBar];
    
    //使用FDFullscreenPopGesture手势滑动返回
//    [self configureGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"didReceiveMemoryWarning class is %@",[self class]);
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)dealloc
{
    NSLog(@"ACBaseViewController dealloc class is %@",[self class]);
}

#pragma mark - config base ViewController
- (void)configureView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)configureNavigationBar
{
    //navigationBar默认是显示，子类如果需要隐藏需要自行设置
    self.navigationController.navigationBarHidden = NO;
    
    //定制返回按钮样式
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)configureGestureRecognizer
{
    UISwipeGestureRecognizer* swipeBackGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(popOrDismissViewController:)];
    swipeBackGesture.direction = UISwipeGestureRecognizerDirectionRight;
    swipeBackGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:swipeBackGesture];
}

#pragma mark - navigationBar button and action
-(UIButton *)backBtn{
    
    if (!_btnBack) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBack.frame = CGRectMake(0, 0, 30, 30);
        _btnBack.backgroundColor = [UIColor clearColor];
        [_btnBack setExclusiveTouch:YES];
        [_btnBack setBackgroundImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        [_btnBack addTarget:self action:@selector(clickNavigationBarBackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}

- (void)clickNavigationBarBackBtnAction:(id)sender
{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //如果子类要实现别的方法可以重写此方法,如果popViewControllerAnimated不能满足需求可以不用调用super方法
    }
}

- (void)popOrDismissViewController:(UIGestureRecognizer*)gesture
{
    if(self.navigationController && !self.presentingViewController){
        [self.navigationController popViewControllerAnimated:YES];
    }else if(self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - scrollToTop
- (void)scrollToTop
{
    NSLog(@"scrollToTop class is %@",NSStringFromClass([self class]));
}
@end
